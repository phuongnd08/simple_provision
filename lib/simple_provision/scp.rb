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
        raise "Both files and scripts are empty. You should provide some"
      end

      system("mkdir tmp")
      system("mkdir tmp/files")
      system("mkdir tmp/scripts")
      files.each do |f|
        system("cp #{f} tmp/files/")
      end
      scripts.each do |f|
        system("cp #{f} tmp/scripts/")
      end

      system("cd tmp && tar -czf #{FILENAME} files/ scripts/")
    end

    def scp_files_to_server
      Net::SCP.start(@host, @username) do |scp|
        scp.upload!("tmp/#{FILENAME}", ".")
      end
    rescue Net::SSH::HostKeyMismatch
      puts "Please run ssh #{@username}@#{@host} to verify the fingerprint first"
    end

    def remove_local_archive
      `rm -rf tmp`
    end
  end
end
