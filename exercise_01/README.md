# de-docker-training
example_01 deals with just pulling and running a simple ubuntu container and run a simple apt update and install

#### pulling a container
```
docker run -it --name my-ubuntu ubuntu

-i: tells docker to run in interactive mode
-t: tells it to allocate a terminal
```
NOTE:
- This will pull the "latest" version of ubuntu if you don't specify a version.  To specify a version add in ":version" after the image name, e.g. ...ubuntu:18.04

#### some switches to remember
> * Noticed how after you excited the container "stopped"?  try using the "-d" switch in your run command to run it in "detached" mode which heads that even if you are not logged in, the container is still running
> * If you wanted to only run in foreground mode and remove the container automatically after exiting the container, then use the "-rm" option with "docker run"
