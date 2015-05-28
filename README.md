This Dockerfile gives you an image with the latest RIDE pulled down from https://github.com/robotframework/RIDE ready to go.

In order to use it:

```
docker run -ti --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  ride
```
and you should be up and running. You'll need an X server on the host, so it should work fine on Linux & OSX. 
