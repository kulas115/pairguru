class Comment < ApplicationRecord
  validates_presence_of :movie, :user, :content
  belongs_to :movie
  belongs_to :user
end
