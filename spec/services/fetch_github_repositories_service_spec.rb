require 'rails_helper'

describe FetchGithubRepositoriesService do 
  describe "#perform" do 
    let(:service) { FetchGithubRepositoriesService.new(ENV["github_oauth_token"]) }
    let(:result) do 
      VCR.use_cassette("services/fetch_github_repositories_services") do 
        service.perform
      end
    end
    it "returns the repositories associated to the user" do 
      expect(result.count).to eq(30)
      expect(result.first.description).to eq("Use Rails and ActiveRecord to build a JSON API which exposes the SalesEngine data schema.")
      expect(result.first.name).to eq("rales_engine")
    end
  end
end