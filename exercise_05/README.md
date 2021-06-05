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
#### lets build image with dbt from previous exercise_03...yay! :-)
> * lets run the command to build the image and start up a container (if you have not yet built the container from example_03/04)
>>      docker compose build
> * this will build an image with the name dbt-base using the Dockerfile from exercise_03/04
> * now lets run the newly created image that contains dbt installed (NOTE: for Mac M1, add "--platform linux/amd64" to the run command)
>>      docker compose up
> * check the dbt version and also the default profile is there
>>      dbt --version
>>      cd ~ && cat .dbt/profiles.yml
> * when we are done, lets shut it down from another terminal (use "docker compose rm" if the images have already stopped)
>>      docker compose down

And that is it for this exercise
