class LikesController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    @like = @photo.likes.build(fan: current_user)
  
    if @like.save
      redirect_back(fallback_location: root_path, notice: 'Like created successfully')
    else
      redirect_back(fallback_location: root_path, alert: 'Unable to like photo')
    end
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    @like = @photo.likes.find_by(fan: current_user)
    
    if @like&.destroy
      redirect_back(fallback_location: root_path, notice: 'Photo unliked successfully')
    else
      redirect_back(fallback_location: root_path, alert: 'Unable to unlike photo')
    end
  end
end
