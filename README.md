# This is based on the awesome work on Fucking Shell Scripts gem

```
──────────────────────────────────────────────────────
Don't forget to also checkout and contribute to
https://github.com/phuongnd08/fucking_scripts_recipes

Let's build awesome recipes to automate deployment
──────────────────────────────────────────────────────
```

Fucking Shell Scripts provides a way to easily config your EC2 server
without all the shitty headache of Chef and Puppy.

Unfortunately, it doesn't provide a way to work with Digital Ocean
server yet.

This is an effort to bring the goodness of Fucking Shell Scripts to
Digital Ocean servers.

I don't use shell in the name of the gems because the gem actually
helps you to run not only shell script, but also ruby and python script
to handle complex build.

Just remember that you need to use shell to install ruby/python first,
and then you can start use ruby/python.

This follow the simple convention of Fucking Shell Scripts:

```
./config_management
├── files
│   ├── keys
│   │   └── deploy_key
│   └── rails_config
│       └── database.yml
├── scripts
│   ├── apt.sh
│   ├── deploy_key.sh
│   ├── git.sh
│   ├── redis.rb
│   ├── ruby2.sh
│   ├── rubygems.sh
│   ├── install_tornado.py
│   ├── search_service_code.sh
│   └── search_service_env.sh
└── servers
    ├── defaults.yml
    └── search-service.yml
```

So: You put definition of each type of server in `servers/type.yml`.
In `files` and `scripts` folder, you place files and scripts that will be
uploaded to the Digital Ocean droplet and executed.

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
