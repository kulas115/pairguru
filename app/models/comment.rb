class Comment < ApplicationRecord
  validates_presence_of :movie, :user, :content
  validates :user_id, uniqueness: { scope: :movie_id, message: "is allowed to post only one comment per movie!" }
  belongs_to :movie
  belongs_to :user
end
