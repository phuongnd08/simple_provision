require "fucking_scripts_digital_ocean/version"

begin
  require 'pry'
rescue LoadError
end

require_relative 'fucking_scripts_digital_ocean/cli'
require_relative 'fucking_scripts_digital_ocean/configuration'
require_relative 'fucking_scripts_digital_ocean/connection'
require_relative 'fucking_scripts_digital_ocean/scp'
require_relative 'fucking_scripts_digital_ocean/server'

require_relative 'ext/fog'
