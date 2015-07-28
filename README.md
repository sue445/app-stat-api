# AppStatApi
[![Circle CI](https://circleci.com/gh/sue445/app-stat-api/tree/master.svg?style=svg)](https://circleci.com/gh/sue445/app-stat-api/tree/master)
[![Dependency Status](https://gemnasium.com/sue445/app-stat-api.svg)](https://gemnasium.com/sue445/app-stat-api)
[![Code Climate](https://codeclimate.com/github/sue445/app-stat-api/badges/gpa.svg)](https://codeclimate.com/github/sue445/app-stat-api)
[![Test Coverage](https://codeclimate.com/github/sue445/app-stat-api/badges/coverage.svg)](https://codeclimate.com/github/sue445/app-stat-api/coverage)

## Requirements
* Ruby 2.2.2
* [memcached](http://memcached.org/)
* [Phantomjs](http://phantomjs.org/)

## Setup
```sh
bundle install
```

## Run
```sh
bundle exec foreman s
```

## Setup Heroku
```sh
heroku addons:create papertrail
heroku addons:create rollbar
heroku addons:create memcachedcloud
heroku config:add BUILDPACK_URL=https://github.com/heroku/heroku-buildpack-multi.git
heroku config:add ROLLBAR_ACCESS_TOKEN=XXXXXXXXXXXXXXX
```
