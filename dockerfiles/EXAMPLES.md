Usage examples
==============

Below are some examples for using queen in docker containers while in development

Launching a queen server instance as a one-shot task (guess application)
------------------------------------------------------------------------

```bash
$ docker run -d -p 9300:9300 --name guessapp guessapp
```

The browsers can connect to http://localhost:9300 to be captured. The browsers will try to guess the server number. The server will exit (and the container too) once the numer is guessed.

Launching a queen server
------------------------

In this example, we create a queen docker container that will act as a pure queen server.

We use the port 9300 to capture browsers, and port 9200 for the clients to connect to (and submit jobs).

```bash
$ docker run -it --rm -p 9200:9200 -p 9300:9300 --name queenserver queen /bin/bash
node@ac811bc93e1d:~/queen/bin$ ./queen -c 0.0.0.0:9300 -h 0.0.0.0:9200
[Queen] Starting...
[Queen] Capturing browsers at http://0.0.0.0:9300/
[Queen] Initializing plugin: monitor
[Queen] Initializing plugin: populator
[Queen Remote Server] Accepting connections on 0.0.0.0:9200
```

Then, we launch another container (a queen client) that will connect the previous one to submit a task to perform :

```bash
$ docker run -it --rm --link queenserver:queenserver --name queenclient queen /bin/bash
node@459a328bdd4a:~/queen/bin$ ./queen -r $QUEENSERVER_PORT_9200_TCP_ADDR:$QUEENSERVER_PORT_9200_TCP_PORT http://queenjs.com/server-example.js
[Queen] Starting...
[Queen Remote Client] Connecting to 172.17.0.7:9200
[Queen Remote Client] New worker provider: Chrome 40.0.2214 (Mac OS X)
[Queen] Loading remote script: http://queenjs.com/server-example.js
[Queen] Executing remote script: http://queenjs.com/server-example.js
532 	 guessed by Chrome 40.0.2214 (Mac OS X)
[...]
Done! The winner was Chrome 40.0.2214 (Mac OS X)
```

In the snippet above, the queen client container has been created with a link to the queenserver container (--link option). Then, we have submitted a task to be performed by the browsers. The -r option tells quenn to connect to the queen server.

The output shows that there is one worker captured by queen (a Chrome browser). When the number has been guessed, the queenclient exits.
