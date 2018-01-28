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

    visit user_path(nickname: "nico24687")

    expect(page).to have_content("nico24687")
    expect(page).to have_xpath("//img[@src=\"http://example.com/nico.jpg\"]")
    expect(page).to have_content("Follower count: 1")
    expect(page).to have_content("Following count: 100")
    expect(page).to have_content("Public repo count: 200")
  end
end