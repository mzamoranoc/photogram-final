class LikesController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    @like = @photo.likes.build(fan: current_user)

    if @like.save
      redirect_to @photo, notice: 'Photo liked.'
    else
      redirect_to @photo, alert: 'Unable to like photo.'
    end
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    @like = @photo.likes.find_by(fan: current_user)
    @like.destroy if @like
    redirect_to @photo, notice: 'Like removed.'
  end
end
