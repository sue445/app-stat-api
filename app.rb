require "sinatra"
require "slim"
require "yaml"
require "active_support/all"
require "apple_system_status"
require "dalli"

def load_countries
  YAML.load_file("#{__dir__}/config/countries.yml").map(&:with_indifferent_access).sort_by { |c| c[:name] }
end

def fetch_apple_system_status(country)
  key = country.presence || "us"
  cache = cache_client

  cached_status = cache.get(key)
  return cached_status if cached_status

  system_status = AppleSystemStatus::Crawler.new.perform(country)
  cache.set(key, system_status)
  system_status
end

def apple_system_status(country, title)
  system_status = fetch_apple_system_status(country)
  return system_status if title.blank?

  system_status[:statuses] = system_status[:statuses].select { |status| status[:title] == title }
  system_status
end

def cache_client
  # TODO: heroku memcached
  Dalli::Client.new("localhost:11211", namespace: "apple_system_status", compress: true, expires_in: 5.minutes)
end

get "/" do
  @countries = load_countries
  slim :index
end

get "/status" do
  system_status = apple_system_status(params[:country], params[:title])
  @title = system_status[:title]
  @statuses = system_status[:statuses]

  slim :status
end
