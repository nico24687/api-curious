class FetchGithubRepositoriesService

  def initialize(oauth_token)
    @faraday = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{oauth_token}"
      faraday.adapter Faraday.default_adapter
    end
  end
  

  def perform
    response = @faraday.get("/user/repos")
    body = JSON.parse(response.body)
  
  
    body.map do |repository_hash| 
      Repository.new(name: repository_hash["name"], description: repository_hash["description"])
    end
  end
end