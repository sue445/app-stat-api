require "uri/https"

describe "config/countries.yml" do # rubocop:disable RSpec/DescribeClass
  countries = YAML.load_file("#{app_dir}/config/countries.yml").map {|c| c["code"] }.reject {|code| code == "us" }

  countries.each do |country|
    url = "https://www.apple.com/#{country}/support/systemstatus/"

    it "#{url} is available" do
      status_code = `curl -s -I #{url} | grep 'HTTP/1.1'`.strip
      expect(status_code).to match /200 OK$/
    end
  end
end
