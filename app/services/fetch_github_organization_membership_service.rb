class FetchGithubOrganizationMembershipService
  attr_reader :token
  def initialize(oauth_token)
    @token = oauth_token
    @faraday = Faraday.new(url: "https://api.github.com") do |faraday|
      # faraday.headers["Authorization"] = "token #{oauth_token}"
      # faraday.headers['X-API-Key'] = ENV['github_client_id']
      faraday.adapter Faraday.default_adapter
    end
  end

 

  def perform 
    response = @faraday.get("/users/nico24687/orgs?access_token=c1e235e93dc7fbed9faed84db52711dd64c8c167")
    JSON.parse(response.body).map do |organization|
      {
        name: organization["login"],
        description: organization["description"],
        avatar_url: organization["avatar_url"]
      }  
    end
    
   
  end
end