class UsersController < ApplicationController
  expose :most_comments_users, -> { User.most_comments }
  
end
