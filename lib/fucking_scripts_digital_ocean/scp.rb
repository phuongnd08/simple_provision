module FuckingScriptsDigitalOcean
  class SCP
    FILENAME = "fss.tar.gz"

    def initialize(server, opts)
      @server, @opts = server, opts
    end

    def to_server
      create_local_archive
      scp_files_to_server
      extract_remote_archive
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

      `tar -czf #{FILENAME} #{includes.join(" ")}`
    end

    def scp_files_to_server
      @server.scp(FILENAME, ".")
    end

    def extract_remote_archive
      @server.ssh("tar -xzf #{FILENAME}")
    end

    def remove_local_archive
      `rm -f #{FILENAME}`
    end
  end
end
