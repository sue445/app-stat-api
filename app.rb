require "sinatra"
require "sinatra/json"
require "slim"
require "yaml"
require "active_support/all"
require "apple_system_status"
require "dalli"
require "rollbar/middleware/sinatra"

class App < Sinatra::Base
  use Rollbar::Middleware::Sinatra

  get "/" do
    @countries = load_countries
    slim :index
  end

  get "/:country/services.json" do
    system_status = find_apple_system_status(params[:country], params[:title])
    json system_status
  end

  get "/:country/services" do
    system_status = find_apple_system_status(params[:country], params[:title])
    @title = system_status[:title]
    @services = system_status[:services]

    slim :services
  end

  before "/:country/services*" do
    unless load_countries.any? { |c| params[:country] == c[:code] }
      halt 404, "Not found"
    end
  end

  helpers do
    def load_countries
      YAML.load_file("#{__dir__}/config/countries.yml").map(&:with_indifferent_access).sort_by { |c| c[:name] }
    end

    def fetch_apple_system_status(country)
      cache = cache_client

      begin
        cached_status = cache.get(country)
        return cached_status if cached_status
      rescue => e
        Rollbar.warning(e)
      end

      system_status = AppleSystemStatus::Crawler.new.perform(country: country)

      begin
        cache.set(country, system_status)
      rescue => e
        Rollbar.warning(e)
      end

      system_status
    end

    def find_apple_system_status(country, title)
      system_status = fetch_apple_system_status(country)
      return system_status if title.blank?

      system_status[:services].select! { |service| service[:title] == title }
      system_status
    end

    def cache_client
      options = { namespace: "apple_system_status", compress: true, expires_in: 5.minutes }

      if ENV["MEMCACHEDCLOUD_SERVERS"]
        # Heroku
        options.merge!(username: ENV["MEMCACHEDCLOUD_USERNAME"], password: ENV["MEMCACHEDCLOUD_PASSWORD"])
        Dalli::Client.new(ENV["MEMCACHEDCLOUD_SERVERS"].split(','), options)
      else
        # localhost
        Dalli::Client.new("localhost:11211", options)
      end
    end

    def service_path(country, args = {})
      format = args.delete(:format)

      path = "/#{country}/services"
      path << ".json" if format == :json
      path << "?" + args.to_query unless args.values.reject(&:blank?).empty?

      path
    end
  end
end
