require "uri/https"

describe "config/countries.yml" do
  where(:country) do
    YAML.load_file("#{app_dir}/config/countries.yml").map{ |c| c["code"] }.reject { |code| code == "us" }.product
  end

  with_them do
    it "url is available" do
      http = Net::HTTP.new("www.apple.com")
      response = http.head("/#{country}/support/systemstatus/")
      expect(response.code).to eq "200"
    end
  end
end
