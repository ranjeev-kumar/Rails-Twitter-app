class Comment < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :user

  validates :body, presence: { message: "Comment shouldn't be blank" }
end
