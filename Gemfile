source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

gem "activesupport", require: "active_support/all"
gem "apple_system_status", "< 1.0.0" # TODO: Upgrade to v1.0.0
gem "capybara", ">= 3.12.0"
gem "dalli"
gem "global"
gem "newrelic_rpm"
gem "nokogiri", ">= 1.11.0.rc4"
gem "poltergeist", ">= 1.18.1"
gem "puma"
gem "puma_worker_killer"
gem "rollbar"
gem "sinatra", ">= 2.1.0"
gem "sinatra-contrib", ">= 2.1.0"
gem "slim"

group :development do
  gem "foreman", require: false
  gem "onkcop", ">= 1.0.0.0", require: false
  gem "rubocop_auto_corrector", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rspec", ">= 2.0.0.pre", require: false
end

group :test do
  gem "rack-test"
  gem "rspec"
  gem "simplecov"
end
