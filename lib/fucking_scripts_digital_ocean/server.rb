require 'shellwords'

module FuckingScriptsDigitalOcean
  class Server
    ServerNotFound = Class.new(StandardError)
    MissingDropletName = Class.new(StandardError)

    attr_reader :server

    def initialize(connection, options)
      @connection, @options = connection, options
    end

    def configure
      get(options[:droplet_name]) if server.nil?
      raise ServerNotFound, "Unable to find server with Droplet name #{options[:droplet_name]}." if server.nil?

      FuckingScriptsDigitalOcean::SCP.new(server, options).to_server
      scripts = options.fetch(:scripts).map do |script|
        "#{environment_exports} bash -c '#{script}'"
      end
      server.ssh(scripts)
    end

    def environment_exports
      @environment_exports ||= begin
                                 if options[:env].nil?
                                   ""
                                 else
                                   options[:env].map { |k, v| [k, Shellwords.escape(v)].join("=") }.join(" ")
                                 end
                               end
    end

    private

    attr_reader :options, :connection

    def get(droplet_name)
      if droplet_name.nil?
        raise FuckingScriptsDigitalOcean::Server::MissingDropletName ,
          "Please specify the Droplet Name using the --droplet-name option."
      end
      @server = connection.servers.detect { |server| server.name == droplet_name }
      if options.has_key?(:private_key_path)
        @server.private_key_path = options.fetch(:private_key_path)
      end
      @server
    end

    def name
      "#{options.fetch(:name).downcase.sub(/ /, '-')}-#{Time.now.strftime("%y-%m-%d-%H-%M")}"
    end
  end
end
