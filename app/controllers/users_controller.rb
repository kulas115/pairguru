class UsersController < ApplicationController
  def most_comments
    @most_comments_users = User.most_comments
  end
end
