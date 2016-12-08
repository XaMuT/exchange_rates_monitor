[![Build Status](https://travis-ci.org/XaMuT/exchange_rates_monitor.svg?branch=master)](https://travis-ci.org/XaMuT/exchange_rates_monitor)

# Dependencies
## With Docker
You need only Docker 1.12
## Without Docker :(
* redis
* nodejs
* phantomjs
* ruby 2.3.3
* bundler

# How to run
## With Docker
```
make build
make run
```
## Without Docker :(
* bundle
* bundle exec rails db:setup
* foreman start

http://localhost:3000 for public page
http://localhost:3000/admin for forced rate form page
