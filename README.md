# FuckingScriptsDigitalOcean

The easiest, most common sense configuration management tool... because you just use fucking shell, ruby, python scripts.

## Installation

Add this line to your application's Gemfile:

    gem 'fucking_scripts_digital_ocean'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fucking_scripts_digital_ocean

## Servers Configuration

### Defaults

Server defaults are defined by creating the following file:

`./servers/defaults.yml`

```yaml
private_key_path: /Users/bhilkert/.ssh/pd-app-server
```

To define a server, create a yaml file in the `./servers` directory with the following format:

`./servers/my-awesome-server.yml`

```yaml
files:
  - files/credentials.yml
scripts:
  - scripts/git.sh
  - scripts/ruby.sh
  - scripts/rubygems.sh
  - scripts/redis.sh
```

## Set up your Digital Ocean server:
`fsdo my-awesome-server --droplet-name YOUR_DROPLET_NAME`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
