class CommentsController < ApplicationController
  before_action :authenticate_user!
  expose :comment
  expose :movie

  def create
    comment = movie.comments.build(comment_params)
    comment.user_id = current_user.id

    redirect_to movie_path(movie)
    if comment.save
      flash[:notice] = "Your comment was created!"
    else
      flash[:danger] = comment.errors.full_messages.join("<br />")
    end
  end

  def destroy
    comment.destroy
    redirect_to movie_path(movie), notice: "Your comment was deleted"
  end

  def update
    if comment.update(comment_params)
      redirect_to movie_path(movie), notice: "Your comment was successfuly edited"
    else
      redirect_to movie_path(movie), alert: "Something went wrong and your comment was not edited"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
