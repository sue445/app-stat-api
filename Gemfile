source "https://rubygems.org"

ruby "2.6.1"

gem "activesupport", require: "active_support/all"
gem "apple_system_status", "< 1.0.0" # TODO: Upgrade to v1.0.0
gem "capybara", ">= 3.12.0"
gem "dalli"
gem "global"
gem "newrelic_rpm"
gem "poltergeist", ">= 1.18.1"
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
