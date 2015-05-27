This Dockerfile gives you an image with the latest RIDE pulled down from https://github.com/robotframework/RIDE and ssh ready to go.
In order to use it:

`ssh -Y root@$DOCKER_IP -p $CONTAINER_PORT` (root password is robotframework) 

`cd /RIDE`

`paver run` 

and you should be up and running. You'll need an X server on the host, so it should work fine on Linux & OSX. 
