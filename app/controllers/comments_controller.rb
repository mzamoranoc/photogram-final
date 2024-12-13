class CommentsController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to @photo, notice: 'Comment was successfully created.'
    else
      redirect_to @photo, alert: 'Unable to add comment.'
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @photo = @comment.photo
    @comment.destroy
    redirect_to @photo, notice: 'Comment was successfully destroyed.'
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
