# Introduction
This based on the work that brandonhilkert initally carried to automate
EC2 deployment with YAML and SHELL script, bring the good spirit: SIMPLE, 
and JUST WORK to the world of Digital Ocean.

### Recipes repo

Don't forget to also checkout and contribute to
https://github.com/phuongnd08/fucking_scripts_recipes

Let's build awesome recipes to automate server provision

# Notes
Remember that this gem treats RUBY and PYTHON the same way it treats the SHELL
script. As long as you write your provision script in proper format,
it will be executed. I often use a mix of SHELL and RUBY scripts to accomplish
the task. SHELL for some simple stuff and RUBY when I need to complete
some tricky part of the configuration.

Just remember that you need to use a shell script to install ruby/python first,
and then you can start use ruby/python. The install of ruby and python can be
as simple as create a bash contains "yum install ruby(python) -y" and include
it in the top of the `scripts` section in your server definition file.

# Project Structure
As simple as it could: One or few servers definition written in YAML + setup scripts written in SHELL, RUBY and PYTHON + text files as resource. It's up to you to use ERB, HAML or any kind of template processors.

```
./provisions
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
env:
  DBNAME: my_db_name
  WEBROOT: /var/www/app
```

#### Passing variables to scripts
Variables defined in `env` will be exposed to scripts during execution.
That way you can use the same scripts for different type of server and
still be able to produce different outcomes.

## Provision your Digital Ocean server:
`fsdo my-awesome-server --droplet-name YOUR_DROPLET_NAME`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
