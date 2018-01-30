class FetchGithubUserService
  def perform(nickname)
    response = Faraday.get("https://api.github.com/users/#{nickname}")
   
    body = JSON.parse(response.body)
   
    
    
    {
      profile_picture_url: body["avatar_url"],
      follower_count: body["followers"],
      following_count: body["following"],
      public_repo_count: body["public_repos"],
      summary: body["bio"]
    }
  end
end