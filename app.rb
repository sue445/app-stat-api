ENV["RACK_ENV"] ||= "development"
Bundler.require(:default, ENV["RACK_ENV"])

require "rollbar/middleware/sinatra"

require_relative "./lib/cache_utils"

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

  before do
    Global.configure do |config|
      config.backend :filesystem, environment: ENV["RACK_ENV"], path: "#{__dir__}/config/global"
    end
  end

  before "/:country/services*" do
    unless load_countries.any? {|c| params[:country] == c[:code] }
      halt 404, "Not found"
    end
  end

  helpers CacheUtils

  helpers do
    def load_countries
      YAML.load_file("#{__dir__}/config/countries.yml").map(&:with_indifferent_access).sort_by {|c| c[:name] }
    end

    def find_apple_system_status(country, title)
      system_status = fetch_apple_system_status(country)
      return system_status if title.blank?

      system_status[:services].select! {|service| service[:title] == title }
      system_status
    end

    def fetch_apple_system_status(country)
      fetch_cache(country) do
        AppleSystemStatus::Crawler.perform(country: country)
      end
    end

    def service_path(country, args = {})
      format = args.delete(:format)

      path = "/#{country}/services"
      path << ".json" if format == :json
      path << "?#{args.to_query}" unless args.values.reject(&:blank?).empty?

      path
    end

    def logger
      @logger ||= Logger.new($stdout)
    end
  end
end
