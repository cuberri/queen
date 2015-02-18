#
# queenjs workspace
#
FROM node:latest
MAINTAINER Christophe Uberri <cuberri@gmail.com>

# A node user to avoid using root as the development user
RUN useradd -ms /bin/bash node

# Recipe from https://github.com/oztu/queen/wiki/Hacking-Queen
# Note : don't know yet why, but the bower installation is needed, as well as
# the "bower install" command executed during the queen installation (see below)
RUN apt-get update && \
	apt-get install -yq --no-install-recommends \
	git
RUN npm install -g grunt-cli bower

# Clone queenjs
WORKDIR /home/node
USER node
RUN git clone git://github.com/turn/queen.git

# Install queen
WORKDIR queen
RUN npm install
RUN bower install
RUN grunt

# Make it executable
WORKDIR bin
RUN chmod u+x queen

# Execute queen and tell the server side to work with the server example script
# provided in the queenjs website
# Allow to override the server side script by using ENTRYPOINT and CMD
ENTRYPOINT ["./queen", "-c", "0.0.0.0:9300"]
CMD ["http://queenjs.com/server-example.js"]

# Using default queenjs port
EXPOSE 9300
