class FetchGithubOrganizationMembershipService
  def initialize(oauth_token)
    @faraday = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{oauth_token}"
      faraday.adapter Faraday.default_adapter
    end
  end

  # "Authorization: token OAUTH-TOKEN"
  # 791f053cbef769e9848135c5d692be1f67f61c51

  def perform 
    response = @faraday.get("/users/nico24687/orgs")
    JSON.parse(response.body).map do |organization|
      {
        name: organization["login"],
        description: organization["description"],
        avatar_url: organization["avatar_url"]
      }  
    end

   
  end
end