[![Build Status](https://travis-ci.org/XaMuT/exchange_rates_monitor.svg?branch=master)](https://travis-ci.org/XaMuT/exchange_rates_monitor)

# 1. Dependencies
## 1.1. With Docker
You need only Docker 1.12

## 1.2. Without Docker :(
* redis
* nodejs
* phantomjs
* ruby 2.3.3
* bundler

# 2. How to run
## 2.1. With Docker
```
make build
make run
```
## 2.2. Without Docker :(
```
bundle
bundle exec rails db:setup
foreman start
```

# 3. Check it
* http://localhost:3000 for public page
* http://localhost:3000/admin for forced rate form page
