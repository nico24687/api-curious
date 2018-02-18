class CreateGithubRepositoryService 
  def initialize(oauth_token)
    @faraday = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{oauth_token}"
      faraday.adapter Faraday.default_adapter
    end
  end

  def perform(repository)
     response = @faraday.post("/user/repos")
     body = JSON.parse(response.body)
  end
end