module FuckingScriptsDigitalOcean
  class Server
    NoServerSelected = Class.new(StandardError)
    MissingDropletName = Class.new(StandardError)

    attr_reader :server

    def initialize(connection, options)
      @connection, @options = connection, options
    end

    def bootstrap
      build
      configure
    end

    def build
      raise "Build is not supported yet"
      @server = connection.servers.create(
        image_id: options.fetch(:image),
        flavor_id: options.fetch(:size),
        key_name: options.fetch(:key_name),
        tags: { "Name" => name },
        groups: options.fetch(:security_groups),
        private_key_path: options.fetch(:private_key_path)
      )
      print "Creating #{options.fetch(:size)} from #{options.fetch(:image)}"

      server.wait_for do
        print "."
        ready?
      end

      puts "ready!"
      puts ""

      print "Waiting for ssh access"

      server.wait_for do
        print "."
        sshable?
      end

      puts "#{server.dns_name} ready!"
    end

    def configure
      get(options[:droplet_name]) if server.nil?
      raise NoServerSelected, "Unable to find server. Try specifying the server ID." if server.nil?

      FuckingScriptsDigitalOcean::SCP.new(server, options).to_server
      server.ssh(options.fetch(:scripts))
    end

    private

    attr_reader :options, :connection

    def get(droplet_name)
      raise FuckingScriptsDigitalOcean::Server::MissingDropletName , "Please specify the Droplet Name using the --droplet-name option." if instance_id.nil?
      @server = connection.servers.get(droplet_name)
      @server.private_key_path = options.fetch(:private_key_path)
      @server
    end

    def name
      "#{options.fetch(:name).downcase.sub(/ /, '-')}-#{Time.now.strftime("%y-%m-%d-%H-%M")}"
    end
  end
end
