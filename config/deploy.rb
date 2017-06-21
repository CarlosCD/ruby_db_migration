# encoding: utf-8

# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'ruby_db_migration'
set :repo_url, 'git@github.com:CarlosCD/ruby_db_migration'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, ENV['DEPLOY_FOLDER']

# Default value for :scm is :git
# Default value for :format is :pretty
# Default value for :log_level is :debug
# Default value for :pty is false
# Default value for :linked_files is []
# Default value for linked_dirs is []
# Default value for default_env is {}
# Default value for keep_releases is 5
