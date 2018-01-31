require 'rails_helper'

describe CreateGithubRepositoryService do 
  describe "#perform" do 
    let(:service) { CreateGithubRepositoryService.new(ENV["github_oauth_token"]) }
    let(:repository) { Repository.new(name: "Example", description: "Example description") }
    let(:result) do 
      VCR.use_cassette("services/create_github_repository_services") do 
        service.perform(repository)
      end
    end
    it "returns a newley created repository" do
      expect(result).to eq(repository)
    end
  end
end