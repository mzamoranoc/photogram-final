class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @users = User.order(username: :asc)
  end

  def show
    @user = User.find_by(username: params[:username])
    if @user
      if @user == current_user || !@user.private? || current_user.following.include?(@user)
        @photos = @user.photos.order(created_at: :desc)
      else
        redirect_to users_path, alert: 'You are not authorized to view this profile.'
      end
    else
      redirect_to users_path, alert: 'User not found.'
    end
  end

  def follow_request
    @user = User.find_by(username: params[:username])
    @follow_request = current_user.sent_follow_requests.build(recipient: @user)
    @follow_request.status = @user.private? ? 'pending' : 'accepted'

    if @follow_request.save
      redirect_to users_path, notice: 'Follow request sent.'
    else
      redirect_to users_path, alert: 'Unable to send follow request.'
    end
  end

  def unfollow_request
    @user = User.find_by(username: params[:username])
    @follow_request = current_user.sent_follow_requests.find_by(recipient_id: @user.id, status: 'accepted')

    if @follow_request&.destroy
      redirect_to users_path, notice: 'Successfully unfollowed.'
    else
      redirect_to users_path, alert: 'Unable to unfollow.'
    end
  end

  def cancel_follow_request
    @user = User.find_by(username: params[:username])
    @follow_request = current_user.sent_follow_requests.find_by(recipient_id: @user.id, status: 'pending')

    if @follow_request&.destroy
      redirect_to users_path, notice: 'Follow request canceled.'
    else
      redirect_to users_path, alert: 'Unable to cancel follow request.'
    end
  end

end
