require_relative "simple_provision/version"

begin
  require 'pry'
rescue LoadError
end

require_relative 'simple_provision/cli'
require_relative 'simple_provision/configuration'
require_relative 'simple_provision/scp'
