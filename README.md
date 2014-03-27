GitStat
=======

## requirement

MongoDB Server

Redis Server

## Installation

```
bundle istall
```
## start project

start sidekiq worker:

```
bundle exec sidekiq -q high,5 default
```

start websocket server:

```
rake websocket_rails:start_server
```

start web server:

```
rails s
```


visit the index from http://localhost:300