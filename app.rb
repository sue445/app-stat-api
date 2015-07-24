require "sinatra"
require "slim"
require "yaml"
require "active_support/all"

def load_countries
  YAML.load_file("#{__dir__}/config/countries.yml").map(&:with_indifferent_access).sort_by { |c| c[:name] }
end

get "/" do
  @countries = load_countries
  slim :index
end
