# Ruby DB Migration

Migration tool to copy a MySQL database into PostgreSQL via the mysql2psql gem (it uses its executable).

It deploys to a server with access to both the MySQL and PostgreSQL servers, but it could also be run locally, if you have local access to both databases.

## Requirements

It assumes Ruby 1.9.3, but also tested with Ruby 2.1 as well.

To be able to install the gems, it requires to have MySQL, with the C libraries. An good option, if you are in macOS, is HomeBrew:

    brew install mysql

## Installation, deployment, settings

Unless environment variables are used, to configure it you would need to replace:

Deployment:

    `config/deploy.rb`:
      DEPLOY_FOLDER: folder in the destination file system (`/var/html/...`)

    `config/deploy/production.rb`:
      RUN_HOST: name of the server you want to deploy to.
      DEPLOY_USER: In the case you use a deployment user, its name.

Databases access details, at `mysql2psql.yml`:

    DB_NAME:     Database name, in this case the same for MySQL and PostgreSQL, but they could use different names, if so decided.

    MySQL database, the one being copied:
      ORIG_SERVER: Host where the MYSQL server resides
      ORIG_USER:   User with access to the database
      ORIG_PASS:   Password for that user

    PostgreSQL database details, the one being created:
      DEST_SERVER: Host where the PostgresQL server resides
      DEST_USER:   User that will own and access the database
      DEST_PASS:   Password for that user

Deployment by Capistrano (in this case considered 'production', role app):

    bundle
    bundle exec cap production deploy

## Running the app and migrating a database

1. Get access to the MySQL server where the database to be copied resides. MySQL could restrict to where connecting is allowed, so set it to be able to connect from the deployment server (`RUN_HOST`).

2. ssh to the destination database server and create a blank database with the desired owner (`DEST_USER`). You would need to have credentials for an user allowed to create databases. For example:

        ssh me@pg_server.example.com
        psql -h localhost -U postgres -c 'CREATE DATABASE my_dest_database WITH OWNER 'my_dest_user';'

3. SSH to the server in which you want to run the migration (`RUN_HOST`), and go to the app's location (`DEPLOY_FOLDER`):

        ssh me@run_server.example.com
        cd  /var/html/etcetera/ruby_db_migration/current

4. Review the file `mysql2psql.yml` for the details on database name, host, credentials, etc. Edit it accordingly (vi?) to set the origin database (MySQL) information, as well as the destination (PostgreSQL):

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

7. Close the ssh connection with the `RUN_SERVER`, and check that the data is at the new PostgreSQL database.

8. Live long and prosper.


`June 2017`
