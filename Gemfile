source "https://rubygems.org"

ruby "2.5.3"

gem "activesupport", require: "active_support/all"
gem "apple_system_status", "< 1.0.0" # TODO: Upgrade to v1.0.0
gem "dalli"
gem "global"
gem "jemalloc", require: false
gem "newrelic_rpm"
gem "puma"
gem "puma-heroku"
gem "puma_worker_killer"
gem "rollbar"
gem "sinatra", ">= 2.0.0"
gem "sinatra-contrib", ">= 2.0.0"
gem "slim"

group :development do
  gem "foreman", require: false
  gem "onkcop", require: false
end

group :test do
  gem "rack-test"
  gem "rspec"
  gem "simplecov"
end
