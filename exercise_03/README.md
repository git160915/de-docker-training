# de-docker-training
example_03 will have us create a Docker file to automatically build dbt

#### Look at the docker file in the src folder of this exercise
```
./src/

```
#### lets build image with dbt from previous exercise_02...yay! :-)
> * lets review the dbt-base.Dockerfile
> * lets run the command to build the image
>>      docker build -f dbt-base.Dockerfile -t dbt-base-amd64 .
> * this will build an image with the name dbt-base-amd64.  NOTE: for Mac M1, add "--platform linux/amd64" to the "docker build..." command or inside the *Dockerfile, update the FROM line to the following:
>       FROM --platform=linux/amd64 ubuntu:${base_image_version}
> * now lets run the newly created image that contains dbt installed (NOTE: for Mac M1, add "--platform linux/amd64" to the run command)
>>      docker run -itd --name dbt-base --platform linux/amd64 dbt-base-amd64
> * check the dbt version and also the default profile is there
>>      dbt --version
>>      cd ~ && cat .dbt/profiles.yml

And that is it for this exercise
