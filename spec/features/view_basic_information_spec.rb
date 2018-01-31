require 'rails_helper'

feature "user visits /nico24687" do 
  let(:user) { User.create!(name: "Nico Lewis", nickname: "nico24687", github_token: "REAL_TOKEN") }
  before do 
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
  scenario "they see basic information on thier profile (profile pic, n starred repos, followers, following)" do

    visit user_path(nickname: user.nickname )

    expect(page).to have_content(user.nickname)
    expect(page).to have_css("img[src*='http://example.com/nico.jpg']")
    expect(page).to have_content("Followers 1")
    expect(page).to have_content("Following 100")
    expect(page).to have_content("Repositories 200")
  end
  scenario "they see information about their previous commit history" do 
      expect_any_instance_of(FetchGithubUserActivityService).to receive(:perform).with(user.nickname).and_return([[{
          sha: "abcde",
          message: "a random message"
      },
      {
          sha: "xyz",
          message: "another random message"
      },
      {
          sha: "pqr",
          message: "even more random message"
      }
      ]])

      visit user_path(nickname: user.nickname)

      expect(page).to have_content("A random message")
  end
  scenario "they see information about the organizations they belong too" do 
      expect_any_instance_of(FetchGithubOrganizationMembershipService).to receive(:perform).and_return([{
        name: "testorg",
        avatar_url:"http://example.com/nicotestorg.jpg" 
      }])


      visit user_path(nickname: user.nickname)

      expect(page).to have_css("img[src*='http://example.com/nicotestorg.jpg']")
  end
  scenario "they can see a list of my repositiories" do 
    repository = Repository.new(name: "testrepository", description: "a random description")

    expect_any_instance_of(FetchGithubRepositoriesService).to receive(:perform).and_return([repository])

    visit user_path(nickname: user.nickname)

    expect(page).to have_content("testrepository")
    expect(page).to have_content("a random description")
  end
  scenario "they can create a repository" do 
    visit user_path(nickname: user.nickname)

    expect(page).to have_link("Create a repository")
  end
end