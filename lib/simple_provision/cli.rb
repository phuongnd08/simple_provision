require 'net/ssh'

module SimpleProvision
  class CLI
    attr_reader :profile, :username, :host
    def initialize(args)
      @profile = args[:profile]
      @username = args[:username]
      @host = args[:host]
    end

    def bootstrap
      SimpleProvision::SCP.new(username, host, options).copy_files
    end

    def configure
      Net::SSH.start(host, username) do |ssh|
        ssh.exec! "tar -xzf #{SimpleProvision::SCP::FILENAME}"
        scripts = options.fetch(:scripts).each do |script|
          puts "Execute #{script}"
          ssh.exec!("#{environment_exports} bash -c '#{script}'") do |channel, stream, data|
            print data
          end
        end
      end
    end

    private

    def environment_exports
      @environment_exports ||= begin
                                 if options[:env].nil?
                                   ""
                                 else
                                   options[:env].map { |k, v| [k, Shellwords.escape(v)].join("=") }.join(" ")
                                 end
                               end
    end

    def server
      SimpleProvision::Server.new(@connection, options)
    end

    def options
      @options ||= SimpleProvision::Configuration.new(@profile).options
    end
  end
end
