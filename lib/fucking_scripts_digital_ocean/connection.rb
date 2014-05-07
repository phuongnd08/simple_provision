require 'fog'

module FuckingScriptsDigitalOcean
  class Connection
    MissingAWSCredentials = Class.new(StandardError)

    def initialize(opts)
      @opts = opts

      if ENV["DIGITAL_OCEAN"].nil? || ENV["AWS_SECRET_ACCESS_KEY"].nil?
        raise FuckingScriptsDigitalOcean::Connection::MissingAWSCredentials, "Make sure AWS_ACCESS_KEY and AWS_SECRET_ACCESS_KEY are environmental variables with your credentials"
      end
    end

    def connection
      @connection ||= begin
        Fog::Compute.new(
          provider: "AWS",
          aws_access_key_id: ENV["AWS_ACCESS_KEY"],
          aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
          region: @opts.fetch(:region)
        )
      end
    end
  end
end
