describe App do
  describe "/" do
    subject do
      get "/"
      last_response
    end

    it { should be_ok }
  end

  describe "/:country/services" do
    subject do
      get "/#{country}/services"
      last_response
    end

    let(:country) { "jp" }

    it { should be_ok }
  end

  describe "/:country/services.json" do
    subject do
      get "/#{country}/services.json"
      last_response
    end

    let(:country) { "jp" }

    it { should be_ok }
  end
end
