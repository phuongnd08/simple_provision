# Introduction
This is based on the work that brandonhilkert initally carried to automate
EC2 instance provision with YAML and SHELL script. It tries to bring the good spirit: SIMPLE, and JUST WORK to the world of every remote machine.

I used to use this to do all the provision of Redis, Postgres, Nginx,
Unicorn, Cron, etc before. These days I just use this to provision
docker on the server and then use crane to orchestrate the rest.

Let's rock.

### Recipes repo

Don't forget to also checkout the recipes collection
https://github.com/phuongnd08/simple_provision_recipes

# How it works
This gem carries the provision by uploading a set of scripts and
files to the server and execute there.

It's up to you to choose the language you want. I often use a mix of
SHELL and RUBY scripts to accomplish the task. SHELL for some simple stuff
like install a package on the server and RUBY when I need to complete
some tricky part of the configuration.

Just remember that you need to use a shell script to install ruby/python first,
and then you can start use ruby/python. The install of ruby and python can be
as simple as create a bash contains "yum install ruby(python) -y" and include
it in the top of the `scripts` section in your server definition file.

## Installation

Add this line to your application's Gemfile:

    gem 'simple_provision'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_provision


# Project Structure
The provision profile need to be defined inside /provision directory.
Since it's just scripting, feel free to use ERB, HAML, or any kind of
templates that you want, assume you install the necessary library before
you do that.

```
./provision
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
    ├── webapp.yml
    ├── docker.yml
    └── search-service.yml
```

In /provision/servers/{webapp, docker, search-service}.yml, you define
your server defintion (read below).

## Server Definition
To define a server type, create a yaml file in the `./provision/servers` directory with the following format:

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

File declared in files and scripts can point to anywhere in the machine
from which you make the provision. The file path is calculated relative
to `./provision` directory. These files/scripts will then be uploaded to
provisioned server at ~/files and ~/scripts

### Passing variables to scripts
Variables defined in `env` will be exposed to scripts during execution.
That way you can re-use the same scripts for different type of servers.

## Provision your server
`bundle exec simpro my-awesome-server root@my-host`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
