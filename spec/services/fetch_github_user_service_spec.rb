require 'rails_helper'

describe FetchGithubUserService do 
  describe "#perform" do 
    let(:service) { FetchGithubUserService.new }

    let(:result) do 
      VCR.use_cassette("services/fetch_github_user_services") do
        service.perform("nico24687")
      end
    end

    it "returns profile picture" do 
      expect(result[:profile_picture_url]).to eq("https://avatars1.githubusercontent.com/u/16985874?v=4")
    end
  
    it "returns number of followers" do
      expect(result[:follower_count]).to eq(1)
    end 

    it "returns number following" do 
      expect(result[:following_count]).to eq(6)
    end

    it "returns number of public repos" do 
      expect(result[:public_repo_count]).to eq(49)
    end
  end
end