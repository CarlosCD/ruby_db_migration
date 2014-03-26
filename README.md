# Ruby DB Migration

Migration tool to copy a MySQL database into PostgreSQL.

By default it deploys to `flux.stsci.edu`, to the folder:

    /var/html/hosts/hubbledev/ruby/ruby_db_migration

## Requirements

It assumes Ruby 1.9.3, but it works with Ruby 2.1 as well.

To be able to install the gems, it requires to have MySQL, with the C libraries. An good option
if you are in Mac OS X is HomeBrew:

    brew install mysql

The destination PostgreSQL database can be created in the destination host, like, for example:

## Installation and deployment

Deployment by Capistrano:

1. `bundle`
2. `bundle exec cap production deploy`

## Running the app

Review the file `mysql2psql.yml` for the details on database, host, credentials, etc.

SSH to the machine, and run it, for example:

    ssh cdupla@flux.stsci.edu
    cd  /var/html/hosts/hubbledev/ruby/ruby_db_migration/current
    bundle exec mysql2psql

March 2014
