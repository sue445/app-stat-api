require "uri/https"

describe "config/countries.yml" do # rubocop:disable RSpec/DescribeClass
  countries = YAML.load_file("#{app_dir}/config/countries.yml").map {|c| c["code"] }.reject {|code| code == "us" }

  countries.each do |country|
    it "https://www.apple.com/#{country}/support/systemstatus/ is available" do
      http = Net::HTTP.new("www.apple.com", 443)
      http.use_ssl = true
      response = http.head("/#{country}/support/systemstatus/")

      # NOTE: https://www.apple.com/cn/support/systemstatus/ is redirected to https://www.apple.com.cn/cn/support/systemstatus/
      expect(response.code).to be_in ["200", "301"]
    end
  end
end
