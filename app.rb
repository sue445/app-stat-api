require "sinatra"
require "slim"
require "yaml"
require "active_support/all"
require "apple_system_status"

def load_countries
  YAML.load_file("#{__dir__}/config/countries.yml").map(&:with_indifferent_access).sort_by { |c| c[:name] }
end

def fetch_apple_system_status(country)
  AppleSystemStatus::Crawler.new.perform(country)
end

get "/" do
  @countries = load_countries
  slim :index
end

get "/status" do
  system_status = fetch_apple_system_status(params[:country])
  @title = system_status[:title]
  @statuses = system_status[:statuses]

  slim :status
end
