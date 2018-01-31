class RepositoriesController < ApplicationController 
  def new

  end

  def create 
    repository = Repository.new(name: params[:name], description: params[:description])
    CreateGithubRepositoryService.new(current_user.github_token).perform(repository)
    redirect_to user_path(nickname: "nico24687")
  end
end