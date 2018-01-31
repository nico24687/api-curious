require 'rails_helper'

feature "user visits new_repository_path" do 
  let(:user) { User.create!(name: "Nico Lewis", nickname: "nico24687", github_token: ENV["github_oauth_token"]) }
  before do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    expect_any_instance_of(FetchGithubUserService).to receive(:perform).with(user.nickname).and_return({
      profile_picture_url: "http://example.com/nico.jpg",
      follower_count: 1,
      following_count: 100,
      public_repo_count: 200
    })

    allow_any_instance_of(FetchGithubUserActivityService).to receive(:perform).with(user.nickname).and_return([])
    allow_any_instance_of(FetchGithubOrganizationMembershipService).to receive(:perform).and_return([])
    allow_any_instance_of(FetchGithubRepositoriesService).to receive(:perform).and_return([])
  end
  scenario "they can create a repository" do 
    visit new_repository_path

    repository = Repository.new(name: "examplerepo", description: "random description")
    expect_any_instance_of(CreateGithubRepositoryService).to receive(:perform).with(repository).and_return(repository)

    fill_in :name, with: "examplerepo"
    fill_in :description, with: "random description"
    
    click_on "Create repository"
    expect(current_path).to eq(user_path(nickname: "nico24687"))
  end

end