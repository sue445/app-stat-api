# NO LONGER MAINTAINED
Heroku recently announced the end of its free plan offerings.

https://blog.heroku.com/next-chapter

This app is running on Heroku Free dyno, but I decided to terminate this app after Heroku's announcement :sob:

* I have no plans to migrate this app from Heroku to another platform. This app is OSS so you can fork it and make it work on another platform
* This app will continue to run until Heroku stops this.  (Probably November 28, 2022 or later)

Thank you.

# AppStatApi
[Apple System Status](https://www.apple.com/support/systemstatus/) UnOfficial API

https://app-stat-api.herokuapp.com/

[![Circle CI](https://circleci.com/gh/sue445/app-stat-api/tree/master.svg?style=svg)](https://circleci.com/gh/sue445/app-stat-api/tree/master)
[![Code Climate](https://codeclimate.com/github/sue445/app-stat-api/badges/gpa.svg)](https://codeclimate.com/github/sue445/app-stat-api)
[![Test Coverage](https://codeclimate.com/github/sue445/app-stat-api/badges/coverage.svg)](https://codeclimate.com/github/sue445/app-stat-api/coverage)

## Requirements
* Ruby
* [memcached](http://memcached.org/)
* [Phantomjs](http://phantomjs.org/) (recommended v1.9.8+)

## Setup
```sh
bundle install
```

## Run
```sh
bundle exec foreman s
open http://localhost:3000/
```

## Setup Heroku
```sh
heroku addons:create papertrail
heroku addons:create rollbar
heroku addons:create memcachedcloud
heroku addons:create newrelic
heroku config:add BUILDPACK_URL=https://github.com/heroku/heroku-buildpack-multi.git
heroku config:add ROLLBAR_ACCESS_TOKEN=XXXXXXXXXXXXXXX
heroku config:add NEW_RELIC_LICENSE_KEY=XXXXXXXXXXXXXXXX
```

### Deploy your Heroku account
[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

## ProTip
core logic is [apple_system_status](https://github.com/sue445/apple_system_status) :gem:
