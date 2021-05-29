# de-docker-training
example_02 will see us setup an image with some tools and then save the state for later use

#### lets start our container
```
docker run -itd --name my-ubuntu ubuntu

If you are on a Mac M1, use the --platform linux/amd64 option with the command above

```
#### lets install dbt...yay! :-)
> * Navigate to this site: https://docs.getdbt.com/dbt-cli/installation
> * run the following commands as pre-installation for ubuntu (for other os please refer to instructions in the above link):
>>      apt update
>>      apt upgrade
> * NOTE: you may encounter issues with installing git, if you do encounter issues with installing git, try these instructions:
> * Khi apt install git thì (trên một số máy windows như em) có thể gặp lỗi thiếu lib dependencies perl-base, thì dùng giải pháp trong link này ạ:
>       https://askubuntu.com/questions/977767/cant-install-git-perl-on-ubuntu-16-04-due-to-broken-packages
>>      apt install git libpq-dev python-dev python3-pip python3-venv -y
>>      apt remove python-cffi
>>      pip install --upgrade cffi
>>      pip install cryptography~=3.4
> * now install dbt
>>      pip install dbt
> * check that dbt is properly instlaled
>       dbt --version
> * try creating/initialising a new project
>>      cd ~ && dbt init my-first-dbt-proj
> * check that a default profile has been created
>>      cat ~/.dbt/profiles.yml
> * NOTE: some additional steps to get sasl package installed (if you want to install the spark profile)
>>      apt install g++ -y
>>      apt install libsasl2-dev -y
>>      pip install sasl
> * now exit the container and it should end up in stopped state.  But what do we do now if we want to remove the container but be able to re-use later, on another machine or share with someone else?  Well, lets "commit" it
> * execute this command to find the container id.  look for container "my-ubuntu"
>>      docker ps -a
> * then run the following command to commit and save the container state to an image called "my-ubuntu-dbt" or whatever name you want to call it
>>      docker commit <CONTAINER ID> my-ubuntu-dbt
> * check that the image has been created by running the following command and looking for the image name in the list of images you have, "my-ubuntu-dbt" in this case
>>      docker images
> * let remove the "my-ubuntu" container you have currently instantiated
>>      docker rm my-ubuntu
> * now lets run the newly created image that contains dbt installed (NOTE: for Mac M1, add "--platform linux/amd64" to the run command)
>>      docker run -it --name my-ubuntu-dbt my-ubuntu-dbt
> * check the dbt version and also the default profile is there
>>      dbt --version
>>      cd ~ && cat .dbt/profiles.yml

And that is it for this exercise
