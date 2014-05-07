module FuckingScriptsDigitalOcean
  class CLI
    def initialize(opts = {})
      @opts = opts
      @connection = FuckingScriptsDigitalOcean::Connection.new(options).connection
    end

    def bootstrap
      server.bootstrap
    end

    def build
      server.build
    end

    def configure
      server.configure
    end

    private

    def server
      FuckingScriptsDigitalOcean::Server.new(@connection, options)
    end

    def options
      @options ||= FuckingScriptsDigitalOcean::Configuration.new(@opts).options
    end
  end
end
