# de-docker-training
example_04 will build and run docker image with docker-compose

#### Look at the docker-compose.yml file
```
"Use your fav edit" to open this file in the: exercse_04/docker-compose.yml
```
#### lets build image with dbt from previous exercise_03...yay! :-)
> * lets run the command to build the image and start up a container
>>      docker compose build
> * this will build an image with the name dbt-base using the Dockerfile from exercise_03
> * now lets run the newly created image that contains dbt installed (NOTE: for Mac M1, add "--platform linux/amd64" to the run command)
>>      docker compose up -d
> * check the dbt version and also the default profile is there
>>      dbt --version
>>      cd ~
>>      dbt init first-dbt-proj
>>      cat ~/.dbt/profiles.yml
> * when we are done, lets shut it down from another terminal (use "docker compose rm" if the images have already stopped)
>>      docker compose down

And that is it for this exercise
