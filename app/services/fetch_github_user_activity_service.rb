class FetchGithubUserActivityService 
  def perform(nickname)
    response = Faraday.get("https://api.github.com/users/#{nickname}/events")

    JSON.parse(response.body)
      .select { |event| event["type"] == "PushEvent"}
      .map { |push_event| to_commit_payload(push_event) }
  end

  private

  def to_commit_payload(push_event)
     push_event["payload"]["commits"].map do |commit| 
        { 
          sha: commit["sha"],
          message: commit["message"]
        } 
      end
  end
end