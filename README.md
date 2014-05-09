# Introduction
This is based on the work that brandonhilkert initally carried to automate
EC2 instance provision with YAML and SHELL script. It tries to bring the good spirit: SIMPLE, and JUST WORK to the world of Digital Ocean.

If you own a Digital Ocean, here is my advice: Chef and Puppet is shitty
thing that just create more problems than it solves. It will take you
days even weeks just to get familar and put things in the right order.

With simple_provision, you get your hand dirty in a few minutes and
we have the working provision profile in just half an hour. From that
moment, provision another instance is just the matter of kicking off
a command from the terminal.

I use simple_provision with mina in my Rails projects and the combination
has been working really well for me.

Let's rock.

### Recipes repo

Don't forget to also checkout the recipes collection
https://github.com/phuongnd08/simple_privision_recipes

# How it works
This gem carries the provision by uploading a set of scripts (and
files) to the server and execute there.

It's up to you to choose the language you want. I often use a mix of
SHELL and RUBY scripts to accomplish the task. SHELL for some simple stuff
like install a package on the server and RUBY when I need to complete
some tricky part of the configuration.

Just remember that you need to use a shell script to install ruby/python first,
and then you can start use ruby/python. The install of ruby and python can be
as simple as create a bash contains "yum install ruby(python) -y" and include
it in the top of the `scripts` section in your server definition file.

# Project Structure
As simple as it could: One or few servers definition written in YAML + setup scripts written in
SHELL, RUBY and PYTHON + text files as resource.
It's up to you to use ERB, HAML or any kind of template processors.

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

    gem 'simple_provision'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_provision

## Servers Configuration

### Server Definition
To define a server type, create a yaml file in the `./servers` directory with the following format:

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

### Shared Definitions

You can share definitions across server types with `./servers/defaults.yml`

```yaml
private_key_path: /Users/bhilkert/.ssh/pd-app-server
```


### Passing variables to scripts
Variables defined in `env` will be exposed to scripts during execution.
That way you can use the same scripts for different type of server and
still be able to produce different outcomes.

## Provision your Digital Ocean server:
`simpro my-awesome-server --droplet-name YOUR_DROPLET_NAME`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
