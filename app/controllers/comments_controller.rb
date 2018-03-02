class CommentsController < ApplicationController
  before_action :find_movie
  before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner]
  before_action :comment_owner, only: [:destroy, :edit, :update]

  def create
    @comment = @movie.comments.build(comment_params)
    @comment.user_id = current_user.id

    redirect_to movie_path(@movie)
    if @comment.save
      flash[:notice] = "Your comment was created!"
    else
      flash[:danger] = @comment.errors.full_messages.join("<br />")
    end
  end

  def destroy
    @comment.destroy
    redirect_to movie_path(@movie), notice: "Your comment was deleted"
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to movie_path(@movie), notice: "Your comment was successfuly edited"
    else
      render 'new'
    end
  end

  private

  def find_movie
    @movie = Movie.find(params[:movie_id])
  end

  def find_comment
    @comment = @movie.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def comment_owner
    unless current_user.id == @comment.user_id
      flash[:notice] = "You cannot edit other user's posts"
      redirect_to movie_path(@movie)
    end
  end
end
