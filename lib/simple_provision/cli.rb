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
      begin
        Net::SSH.start(host, username, :forward_agent => true) do |ssh|
          ssh.exec! "tar -xzf #{SimpleProvision::SCP::FILENAME}"
          scripts = options.fetch(:scripts).each do |script|
            puts "Execute #{script}"
            ssh.open_channel do |ssh_channel|
              ssh_channel.request_pty
              ssh_channel.exec("#{environment_exports} bash -c '#{script}'") do |channel, success|
                unless success
                  raise "Could not execute command: #{command.inspect}"
                end

                channel.on_data do |ch, data|
                  STDOUT << data
                end

                channel.on_extended_data do |ch, type, data|
                  next unless type == 1
                  STDERR << data
                end
              end
            end
            ssh.loop
          end
        end
      rescue Net::SSH::HostKeyMismatch => exception
        exception.remember_host!
        sleep 0.2
        retry
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
