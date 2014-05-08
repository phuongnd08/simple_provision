module SimpleProvision
  class CLI
    def initialize(opts = {})
      @opts = opts
      @connection = SimpleProvision::Connection.new(options).connection
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
      SimpleProvision::Server.new(@connection, options)
    end

    def options
      @options ||= SimpleProvision::Configuration.new(@opts).options
    end
  end
end
