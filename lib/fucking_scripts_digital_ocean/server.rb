module FuckingScriptsDigitalOcean
  class Server
    NoServerSelected = Class.new(StandardError)
    MissingDropletName = Class.new(StandardError)

    attr_reader :server

    def initialize(connection, options)
      @connection, @options = connection, options
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
      if droplet_name.nil?
        raise FuckingScriptsDigitalOcean::Server::MissingDropletName ,
          "Please specify the Droplet Name using the --droplet-name option."
      end
      @server = connection.servers.get(droplet_name)
      @server.private_key_path = options.fetch(:private_key_path)
      @server
    end

    def name
      "#{options.fetch(:name).downcase.sub(/ /, '-')}-#{Time.now.strftime("%y-%m-%d-%H-%M")}"
    end
  end
end
