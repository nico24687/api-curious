require 'rails_helper'

describe User do 
  let(:auth_hash) do
  {"provider"=>"github",
 "uid"=>"16985874",
 "info"=>
  {"nickname"=>"nico24687",
   "email"=>nil,
   "name"=>"Nico Lewis",
   "image"=>"https://avatars1.githubusercontent.com/u/16985874?v=4",
   "urls"=>{"GitHub"=>"https://github.com/nico24687", "Blog"=>""}},
 "credentials"=>{"token"=>"REAL_TOKEN", "expires"=>false},
 "extra"=>
  {"raw_info"=>
    {"login"=>"nico24687",
     "id"=>16985874,
     "avatar_url"=>"https://avatars1.githubusercontent.com/u/16985874?v=4",
     "gravatar_id"=>"",
     "url"=>"https://api.github.com/users/nico24687",
     "html_url"=>"https://github.com/nico24687",
     "followers_url"=>"https://api.github.com/users/nico24687/followers",
     "following_url"=>"https://api.github.com/users/nico24687/following{/other_user}",
     "gists_url"=>"https://api.github.com/users/nico24687/gists{/gist_id}",
     "starred_url"=>"https://api.github.com/users/nico24687/starred{/owner}{/repo}",
     "subscriptions_url"=>"https://api.github.com/users/nico24687/subscriptions",
     "organizations_url"=>"https://api.github.com/users/nico24687/orgs",
     "repos_url"=>"https://api.github.com/users/nico24687/repos",
     "events_url"=>"https://api.github.com/users/nico24687/events{/privacy}",
     "received_events_url"=>"https://api.github.com/users/nico24687/received_events",
     "type"=>"User",
     "site_admin"=>false,
     "name"=>"Nico Lewis",
     "company"=>nil,
     "blog"=>"",
     "location"=>nil,
     "email"=>nil,
     "hireable"=>nil,
     "bio"=>"Software Developer || UI/UX Designer",
     "public_repos"=>49,
     "public_gists"=>3,
     "followers"=>1,
     "following"=>6,
     "created_at"=>"2016-01-31T12:42:16Z",
     "updated_at"=>"2018-01-28T00:53:54Z"},
   "all_emails"=>[]}}
  end

  describe "find_or_create_from_auth_hash" do 
    context "when user does not exist for github token" do 
      it "creates a new user with the github token" do 
        user = User.find_or_create_from_auth_hash(auth_hash)

        expect(user.github_token).to eq("REAL_TOKEN")
        expect(user.nickname).to eq("nico24687")
        expect(user.name).to eq("Nico Lewis")
        expect(User.count).to eq(1)
      end
    end
    context "when user does exist for github token" do 
      it "returns the existing user with the matching github token" do 
        user = User.create!(name: "Nico Lewis", nickname: "nico2467", github_token: "REAL_TOKEN")

        user = User.find_or_create_from_auth_hash(auth_hash)

        expect(user.github_token).to eq("REAL_TOKEN")
        expect(user.nickname).to eq("nico2467")
        expect(user.name).to eq("Nico Lewis")
        expect(User.count).to eq(1)
      end
    end
  end
end