#
# queenjs workspace
#
FROM queen:latest
MAINTAINER Christophe Uberri <cuberri@gmail.com>

# Create a queen server that captures browsers on the 9300 port
# (Thus, the browsers are connecting to the default 80 port)
# Run the script provided in the queenjs website
# Allow to override the server side script by using ENTRYPOINT and CMD
ENTRYPOINT ["./queen", "-c", "0.0.0.0:9300"]
CMD ["http://queenjs.com/server-example.js"]

# Expose the TCP port for the applications to connect to the server
EXPOSE 9300
