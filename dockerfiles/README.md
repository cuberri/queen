Dockerfiles
===========

## queen

This Dockerfile builds a base queen image containg the queen binary. The build process is made from source located in the master branch of the queen github base project.

Please have a look at the Dockerfile for the details about node version and stuff.

Be sure to build this image before anyone else.

```bash
dockerfiles $ docker build -t queen queen/
```

## guessapp

This Dockerfile builds an image that launches a queen server on the 9300 port and runs the _guess_ example script located at http://queenjs.com/server-example.js

This image is based on the _queen_ image. Be sure to build it before this one.

```bash
dockerfiles $ docker build -t guessapp guessapp/
dockerfiles $ docker run -d -p 9300:9300 --name guessapp guessapp
```

Point your browser on localhost:9300 and it will begin guessing numbers.

## More to come...
