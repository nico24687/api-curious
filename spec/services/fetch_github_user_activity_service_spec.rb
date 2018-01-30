require 'rails_helper'

describe FetchGithubUserActivityService do 
  describe "#perform" do 
    let(:service) { FetchGithubUserActivityService.new }
    let(:result) do
        VCR.use_cassette("services/fetch_github_user_activity_services") do 
           service.perform("nico24687")
        end  
    end

    it "returns information from the users feed" do 
      
      # expect(result.map { |event| event["type"] }.uniq).to eq("")
      expect(result.count).to eq(17)
      expect(result.first.first[:sha]).to eq("56202dacb3d884d40873a6f6b465d99ad50a0ecf")
      expect(result.first.first[:message]).to eq("no longer have a reports controller for customers")
    end

  end
end