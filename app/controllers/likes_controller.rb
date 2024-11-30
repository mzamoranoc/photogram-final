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

  def create
    @photo = Photo.find(params[:photo_id])
    @like = @photo.likes.build(fan: current_user)
  
    if @like.save
      redirect_to root_path, notice: 'Photo was successfully liked.'
    else
      redirect_to root_path, alert: 'Unable to like the photo.'
    end
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    @like = @photo.likes.find_by(fan: current_user)
  
    if @like
      @like.destroy
      redirect_to root_path, alert: 'Photo was successfully unliked.'
    else
      redirect_to root_path, alert: 'Unable to unlike the photo.'
    end
  end
end
