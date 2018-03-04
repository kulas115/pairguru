class GenresController < ApplicationController
  expose :genres, -> { Genre.all.decorate }
  expose :genre,  -> { Genre.find(params[:id]).decorate }

end
