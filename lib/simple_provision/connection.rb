require 'fog'

module SimpleProvision
  class Connection
    MissingDigitalOceanCredentials = Class.new(StandardError)

    def initialize(opts)
      @opts = opts

      if ENV["DIGITAL_OCEAN_API_KEY"].nil? || ENV["DIGITAL_OCEAN_CLIENT_ID"].nil?
        raise SimpleProvision::Connection::MissingDigitalOceanCredentials, "Make sure DIGITAL_OCEAN_API_KEY and DIGITAL_OCEAN_CLIENT_ID are environmental variables with your credentials"
      end
    end

    def connection
      @connection ||= begin
        Fog::Compute.new(
          provider: "DigitalOcean",
          digitalocean_client_id: ENV["DIGITAL_OCEAN_CLIENT_ID"],
          digitalocean_api_key: ENV["DIGITAL_OCEAN_API_KEY"]
        )
      end
    end
  end
end
