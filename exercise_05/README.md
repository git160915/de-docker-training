# de-docker-training
example_05 will build and run docker image with docker-compose but with the addition of a postgres db and adminer to login to the db as well as run a sample dbt project from [dbt fishtown github site](https://github.com/fishtown-analytics/jaffle_shop).

#### Look at the docker-compose.yml file
```
"Use your fav edit" to open this file in the: exercse_05/docker-compose.yml

Note:
- The use of "ports"
- The use of "environment"
- The use of "volumes"
```
#### lets build image with dbt from previous exercise_04...yay! :-)
> * lets run the command to build the image and start up a container (if you have not yet built the container from example_03/04)
>>      docker compose build
> * this will build an image with the name dbt-base using the Dockerfile from exercise_03/04
> * now lets run the newly created image that contains dbt installed (NOTE: for Mac M1, add "--platform linux/amd64" to the run command)
>>      docker compose up
>>      
>>      NOTE: you will notice a whole bunch of logs
> * check the dbt version
>>      dbt --version
> * now lets create a default project in the data-warehouse folder and checkout the default dbt profile
>>      cd /data-warehouse
>>      dbt init first-dbt-proj
>>      cat ~/.dbt/profiles.yml
> * now lets go back to the /data-warehouse folder and grab the jaffle_shop sample project from fishtown-analytics git repo
>>      cd /data-warehouse && git clone https://github.com/fishtown-analytics/jaffle_shop.git
> * lets edit the default profile (~/.dbt/profiles.yml) to add in a postgres db profile so we can run the sample project against a postgres db.  Or take the sample profile.yml from the exercise_05/sample folder.  If you want to edit the file directly, add the following to the end of the file:
>>      jaffle_shop:
>>        target: dev
>>        outputs:
>>          dev:
>>            type: postgres
>>            host: postgres-db
>>            user: postgres
>>            password: example
>>            port: 5432
>>            dbname: postgres
>>            schema: public
>>            threads: 1
> * go to the jaffle_shop folder
>>      cd jaffle_shop
> * lets first debug our connection to check its all good
>>      dbt debug
>>      
>>      NOTE: You should see something like the following.  If not, check your dbt profile settings again, maybe there was a typo
>>      Running with dbt=0.19.1
>>      dbt version: 0.19.1
>>      python version: 3.8.5
>>      python path: /usr/bin/python3
>>      os info: Linux-5.10.25-linuxkit-x86_64-with-glibc2.29
>>      Using profiles.yml file at /root/.dbt/profiles.yml
>>      Using dbt_project.yml file at /data-warehouse/jaffle_shop/dbt_project.yml
>>      
>>      Configuration:
>>        profiles.yml file [OK found and valid]
>>        dbt_project.yml file [OK found and valid]
>>      
>>      Required dependencies:
>>       - git [OK found]
>>      
>>      Connection:
>>        host: postgres-db
>>        port: 5432
>>        user: postgres
>>        database: postgres
>>        schema: jaffle_shop
>>        search_path: None
>>        keepalives_idle: 0
>>        sslmode: None
>>        Connection test: OK connection ok
>>      
> * now lets seed some raw data.  This is normally not needed but for this example we will seed some data.  dbt seed is normally used to load static data, its not meant to be used to load for example delta processing or CDC
>>      dbt seed
>>      
>>      Running with dbt=0.19.1
>>      Found 5 models, 20 tests, 0 snapshots, 0 analyses, 138 macros, 0 operations, 3 seed files, 0 sources, 0 exposures
>>      
>>      02:56:20 | Concurrency: 1 threads (target='dev')
>>      02:56:20 |
>>      02:56:20 | 1 of 3 START seed file jaffle_shop.raw_customers..................... [RUN]
>>      * Deprecation Warning: The quote_columns parameter was not set for seeds, so the
>>      default value of False was chosen. The default will change to True in a future
>>      release.
>>      
>>      For more information, see:
>>      https://docs.getdbt.com/v0.15/docs/seeds#section-specify-column-quoting
>>      02:56:20 | 1 of 3 OK loaded seed file jaffle_shop.raw_customers................. [INSERT 100 in 0.30s]
>>      02:56:20 | 2 of 3 START seed file jaffle_shop.raw_orders........................ [RUN]
>>      02:56:20 | 2 of 3 OK loaded seed file jaffle_shop.raw_orders.................... [INSERT 99 in 0.10s]
>>      02:56:20 | 3 of 3 START seed file jaffle_shop.raw_payments...................... [RUN]
>>      02:56:21 | 3 of 3 OK loaded seed file jaffle_shop.raw_payments.................. [INSERT 113 in 0.10s]
>>      02:56:21 |
>>      02:56:21 | Finished running 3 seeds in 0.92s.
>>      
>>      Completed successfully
>>      
>>      Done. PASS=3 WARN=0 ERROR=0 SKIP=0 TOTAL=3
>>      
> * now go to the localhost:8080 and login to postgres-db, username: postgres, password: example and checkout the jaffle_shop schema and you'll notice 3 raw_* tables
>>      raw_customers
>>      raw_orders
>>      raw_payments
> * now run the models and notice the models/tables created
>>      dbt run
>>      
>>      This will output the following:
>>      
>>      Running with dbt=0.19.1
>>      Found 5 models, 20 tests, 0 snapshots, 0 analyses, 138 macros, 0 operations, 3 seed files, 0 sources, 0 exposures
>>      
>>      02:57:39 | Concurrency: 1 threads (target='dev')
>>      02:57:39 |
>>      02:57:39 | 1 of 5 START view model jaffle_shop.stg_orders....................... [RUN]
>>      02:57:40 | 1 of 5 OK created view model jaffle_shop.stg_orders.................. [CREATE VIEW in 0.28s]
>>      02:57:40 | 2 of 5 START view model jaffle_shop.stg_payments..................... [RUN]
>>      02:57:40 | 2 of 5 OK created view model jaffle_shop.stg_payments................ [CREATE VIEW in 0.10s]
>>      02:57:40 | 3 of 5 START view model jaffle_shop.stg_customers.................... [RUN]
>>      02:57:40 | 3 of 5 OK created view model jaffle_shop.stg_customers............... [CREATE VIEW in 0.10s]
>>      02:57:40 | 4 of 5 START table model jaffle_shop.orders.......................... [RUN]
>>      02:57:40 | 4 of 5 OK created table model jaffle_shop.orders..................... [SELECT 99 in 0.18s]
>>      02:57:40 | 5 of 5 START table model jaffle_shop.customers....................... [RUN]
>>      02:57:40 | 5 of 5 OK created table model jaffle_shop.customers.................. [SELECT 100 in 0.11s]
>>      02:57:40 |
>>      02:57:40 | Finished running 3 view models, 2 table models in 1.18s.
>>      
>>      Completed successfully
>>      
>>      Done. PASS=5 WARN=0 ERROR=0 SKIP=0 TOTAL=5
> * you'll notice the tables created when viewing from adminer and the schema jaffle_shop
> * when we are done, lets shut it down from another terminal (use "docker compose rm" if the images have already stopped)
>>      docker compose down

And that is it for this exercise
