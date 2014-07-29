# Ruby DB Migration

Migration tool to copy a MySQL database into PostgreSQL via the mysql2psql gem (it uses its executable).

By default it deploys to `flux.stsci.edu`, to the folder:

    /var/html/hosts/hubbledev/ruby/ruby_db_migration

## Requirements

It assumes Ruby 1.9.3, but it works with Ruby 2.1 as well.

To be able to install the gems, it requires to have MySQL, with the C libraries. An good option if you are in Mac OS X is HomeBrew:

    brew install mysql

## Installation and deployment

Deployment by Capistrano to flux (in this case considered 'production', role app):

    bundle
    bundle exec cap production deploy

## Running the app and migrating a database

1. Get access to the MySQL server where the database to be copied resides. MySQL could restrict to where connecting is allowed, so set it to be able to connect from flux.sitsci.edu

2. ssh to the destination database server and create a blank database with the desired owner. You would need to have the password for a user allowed to create databases. For example:

        ssh cdupla@lopodb01.stsci.edu
        psql -h localhost -U postgres -c 'CREATE DATABASE steel_amazing_space_feedback WITH OWNER 'hubble';'

3. SSH to Flux, and go to the ruby_db_migration app location

        ssh cdupla@flux.stsci.edu
        cd  /var/html/hosts/hubbledev/ruby/ruby_db_migration/current

4. Review the file `mysql2psql.yml` for the details on database name, host, credentials, etc. Edit it accordingly (vi?) to set the origin database (MySQL) information, as well as the destination (PostgreSQL). Note: `mysql2psql.yml` may be readonly for the group (admin issue pending to be resolved by the IT department):

        chmod g+w mysql2psql.yml
        vi mysql2psql.yml

5. Run the program. It may take some time, based on network load and amount of information contained in the database.

        bundle exec mysql2psql

6. Remove the credentials from `mysql2psql.yml`, both for security and to make sure that the script is not accidentally executed again, and the destination database rewritten:

        mysql:
          ...
          password: secret
          ...

        destination:
          postgres:
            ...
            password: secret
            ...

7. Close the ssh connection with flux, and check that the data is at lopodb01.stsci.edu

8. Live long and prosper.

July 2014
