require 'rails_helper'

feature "user visits /nico24687" do 
  scenario "they see basic information on thier profile (profile pic, n starred repos, followers, following)" do 
    user = User.create!(name: "Nico Lewis", nickname: "nico24687", github_token: "REAL_TOKEN")

    expect_any_instance_of(FetchGithubUserService).to receive(:perform).with("nico24687").and_return({
      profile_picture_url: "http://example.com/nico.jpg",
      follower_count: 1,
      following_count: 100,
      public_repo_count: 200
    })

    expect_any_instance_of(FetchGithubUserActivityService).to receive(:perform).with("nico24687").and_return([])

    expect_any_instance_of(FetchGithubOrganizationMembershipService).to receive(:perform).and_return([])


    visit user_path(nickname: "nico24687")

    expect(page).to have_content("nico24687")
    expect(page).to have_css("img[src*='http://example.com/nico.jpg']")
    expect(page).to have_content("Followers 1")
    expect(page).to have_content("Following 100")
    expect(page).to have_content("Repositories 200")
  end
  scenario "they see information about their previous commit history" do 
    user = User.create!(name: "Nico Lewis", nickname: "nico24687", github_token: "REAL_TOKEN")

      expect_any_instance_of(FetchGithubUserService).to receive(:perform).with("nico24687").and_return({
      profile_picture_url: "http://example.com/nico.jpg",
      follower_count: 1,
      following_count: 100,
      public_repo_count: 200
    })

      expect_any_instance_of(FetchGithubOrganizationMembershipService).to receive(:perform).and_return([])

      expect_any_instance_of(FetchGithubUserActivityService).to receive(:perform).with("nico24687").and_return([[{
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

      visit user_path(nickname: "nico24687")

      expect(page).to have_content("a random message")
  end
  scenario "they see information about the organizations they belong too" do 
      user = User.create!(name: "Nico Lewis", nickname: "nico24687", github_token: "REAL_TOKEN")

      expect_any_instance_of(FetchGithubUserService).to receive(:perform).with("nico24687").and_return({
      profile_picture_url: "http://example.com/nico.jpg",
      follower_count: 1,
      following_count: 100,
      public_repo_count: 200
    })

      expect_any_instance_of(FetchGithubUserActivityService).to receive(:perform).with("nico24687").and_return([])

      expect_any_instance_of(FetchGithubOrganizationMembershipService).to receive(:perform).and_return([{
        name: "testorg"
      }])


      visit user_path(nickname: "nico24687")

      expect(page).to have_content("testorg")
  end
end