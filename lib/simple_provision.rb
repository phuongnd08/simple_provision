require "simple_provision/version"

begin
  require 'pry'
rescue LoadError
end

require_relative 'simple_provision/cli'
require_relative 'simple_provision/configuration'
require_relative 'simple_provision/connection'
require_relative 'simple_provision/scp'
require_relative 'simple_provision/server'

require_relative 'ext/fog'
