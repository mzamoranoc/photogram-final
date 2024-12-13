class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index] #borre show en [:index, :show]

  def index
    @photos = Photo.all.order(created_at: :desc)
  end

 
  def show
    @photo = Photo.find(params[:id])
  end
  
  def new
    @photo = current_user.photos.build
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      redirect_to @photo, notice: 'Photo was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @photo.update(photo_params)
      redirect_to @photo, notice: 'Photo was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @photo.destroy
    redirect_to photos_url, notice: 'Photo was successfully deleted.'
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:caption, :image)
  end
end
