Table Tennis Score Board
=======================

Implements a table tennis scoreboard which can be updated by PUTing to
particular URL's. This was part of a hack day project that involved buttons
hooked up to an [ESP-01](http://esp8266.co.uk/shop/esp-01) module programmed to
hit the REST end points to update the scores.

Games are automatically updated when a player wins (score hits at least 11 and
is a clear 2 point lead). Players automatically switch sides between games.

The back end is Sinatra and the front end is powered by Riot.js. Redis is used
for data persistence. Pusher is used for communication between the back end and
the front.

Instructions
------------

Install the bundle:

```sh
$ bundle install
```

Run the server:

```sh
$ bundle exec foreman start
```
