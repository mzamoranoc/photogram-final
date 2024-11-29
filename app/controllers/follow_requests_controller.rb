class FollowRequestsController < ApplicationController
  def create
    @recipient = User.find(params[:recipient_id])
    @follow_request = current_user.sent_follow_requests.build(recipient: @recipient)

    if @recipient.private?
      @follow_request.status = 'pending'
    else
      @follow_request.status = 'accepted'
    end

    if @follow_request.save
      redirect_to users_path, notice: 'Follow request sent.'
    else
      redirect_to users_path, alert: 'Unable to send follow request.'
    end
  end

  def accept
    @follow_request = current_user.received_follow_requests.find(params[:id])
    @follow_request.update(status: 'accepted')
    redirect_to user_path(current_user), notice: 'Follow request accepted.'
  end

  def reject
    @follow_request = current_user.received_follow_requests.find(params[:id])
    @follow_request.update(status: 'rejected')
    redirect_to user_path(current_user), notice: 'Follow request rejected.'
  end

  def destroy
    @follow_request = current_user.sent_follow_requests.find(params[:id])
    @follow_request.destroy
    redirect_to users_path, notice: 'Follow request canceled.'
  end
end
