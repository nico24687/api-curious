class UsersController < ApplicationController 
  def show 
    @user = User.find_by(nickname: params[:nickname])
    @github = FetchGithubUserService.new.perform(@user.nickname)
    @github_activity = FetchGithubUserActivityService.new.perform(@user.nickname)
    @github_organizations = FetchGithubOrganizationMembershipService.new(@user.github_token).perform
    @repos = FetchGithubRepositoriesService.new(@user.github_token).perform
  end
end