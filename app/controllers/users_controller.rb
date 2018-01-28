class UsersController < ApplicationController 
  def show 
    @user = User.find_by(nickname: params[:nickname])
    @github = FetchGithubUserService.new.perform(@user.nickname)
  end
end