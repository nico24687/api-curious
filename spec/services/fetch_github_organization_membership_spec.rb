require "rails_helper"

describe FetchGithubOrganizationMembershipService do 
  describe "#perform" do 
    let(:service) { FetchGithubOrganizationMembershipService.new(ENV["github_oauth_token"]) }
    let(:result) do 
      VCR.use_cassette("services/fetch_github_organization_membership_services") do 
        service.perform
      end
    end
    it "returns infomration about the users organizations" do
      expect(result).to eq([{name: "Artegee", description: "Social selling platform for the arts", avatar_url: "https://avatars1.githubusercontent.com/u/35905304?v=4"}])
    end
  end
end