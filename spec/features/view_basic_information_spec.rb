require 'rails_helper'

feature "user visits /nico24687" do 
  scenario "they see basic information on thier profile (profile pic, n starred repos, followers, following)" do 
    user = User.create!(name: "Nico Lewis", nickname: "nico24687", github_token: "REAL_TOKEN")

    visit user_path(nickname: "nico24687")

    expect(page).to have_content("nico24687")
    expect(page).to have_content("")
  end
end