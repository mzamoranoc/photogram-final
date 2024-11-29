class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @users = User.order(username: :asc)
  end

  def show
    @user = User.find_by(username: params[:username])
    if @user
      if @user == current_user || !@user.private? || current_user.following_users.include?(@user)
        @photos = @user.photos.order(created_at: :desc)
      else
        redirect_to users_path, alert: 'You are not authorized to view this profile.'
      end
    else
      redirect_to users_path, alert: 'User not found.'
    end
  end
end
