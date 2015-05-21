Winston log-viewer
==================

A simple and basic app to read streamed logs via node's winston.

### Setup and run the viewer
- if you don't have meteor yet, _you can_ install it with `curl https://install.meteor.com/ | sh`
- install and with: `meteor run`
- then open your browser and go on [localhost:3000](http://localhost:3000/)

### Configure in your logs providers
- go where you define your winston transporters
- add the following transporter:
```coffee
  t = new winston.transporters.Webhook({
    host: 'localhost'
    port: 3000
    path: '/methods/log'
    level: 'silly'
    colorize: true
  });
```
- and now things just works
