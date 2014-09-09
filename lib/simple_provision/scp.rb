require 'net/scp'
module SimpleProvision
  class SCP
    FILENAME = "simpro.tar.gz"

    def initialize(username, host, opts)
      @username, @host, @opts = username, host, opts
    end

    def copy_files
      create_local_archive
      scp_files_to_server
      remove_local_archive
    end

    private

    def create_local_archive
      files = @opts[:files] || []
      scripts = @opts[:scripts] || []
      includes = files + scripts

      if includes.empty?
        raise "Both files and scripts are empty. You should provide some."
      end

      cmds = [
        "cd provision",
        "rm -rf tmp",
        "mkdir tmp",
        "mkdir tmp/files",
        "mkdir tmp/scripts"
      ]

      files.each { |f| cmds << "cp #{f} tmp/files/"}

      scripts.each { |f| cmds << "cp #{f} tmp/scripts/" }

      cmds << "cd tmp && tar -czf #{FILENAME} files/ scripts/"

      if ENV["VERBOSE"]
        puts "==============Execute Locally============"
        puts cmds.join("\n")
        puts "========================================="
      end
      system cmds.join("\n")
    end

    def scp_files_to_server
      path = "provision/tmp/#{FILENAME}"

      Net::SCP.start(@host, @username) do |scp|
        scp.upload!(path, ".")
      end
    rescue Net::SSH::HostKeyMismatch
      puts "Please run ssh #{@username}@#{@host} to verify the fingerprint first"
    end

    def remove_local_archive
      cmds = [
        "cd provision",
        "rm -rf tmp"
      ]

      system cmds.join("\n")
    end
  end
end
