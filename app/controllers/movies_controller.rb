class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]
  expose :movies, -> { Movie.includes(:genre).all.decorate }
  expose :movie
  expose :comments, -> { Comment.where(movie_id: movie).order(created_at: :desc) }
  before_action :admin, only: [:edit, :update]

  def update
    if movie.update(movie_params)
      redirect_to movie_path(movie), notice: "Your movie was successfuly edited"
    else
      render 'edit'
    end
  end

  def send_info
    movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, movie).deliver_now
    redirect_to :back, notice: "Email sent with movie info"
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :genre_id)
  end

  def admin
    if current_user.role != 'admin'
      redirect_to movies_path, notice: "You are not allowed to edit"
    end
  end
end
