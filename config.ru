require "./app"
require "newrelic_rpm"
require "rollbar"

Rollbar.configure do |config|
  config.access_token = ENV["ROLLBAR_ACCESS_TOKEN"]
  config.enabled      = ENV["ROLLBAR_ACCESS_TOKEN"].present?

  config.exception_level_filters.merge!(
    "Sinatra::NotFound" => "ignore",
  )
end

NewRelic::Agent.after_fork(force_reconnect: true)

run App
