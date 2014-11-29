require 'yaml'
require 'erb'

module SimpleProvision
  class Configuration
    MissingServerType = Class.new(StandardError)
    MissingServerConfiguration = Class.new(StandardError)

    attr_reader :options
    attr_reader :profile

    def initialize(profile)
      @profile = profile

      read_and_parse_server_options
    end

    private

    def default_options
      begin
        YAML.load(ERB.new(File.read(default_file)).result)
      rescue Errno::ENOENT
        {}
      end
    end

    def server_options
      begin
        YAML.load(ERB.new(File.read(server_file)).result)
      rescue Errno::ENOENT
        raise MissingServerConfiguration, "Please create a configuration file at '#{server_file}'"
      end
    end

    def default_file
      "provision/servers/default.yml"
    end

    def server_file
      "provision/servers/#{profile}.yml"
    end

    def read_and_parse_server_options
      options_string_hash = default_options.merge(server_options)
      @options = Hash[options_string_hash.map{ |(k,v)| [k.to_sym, v] }]
    end
  end
end
