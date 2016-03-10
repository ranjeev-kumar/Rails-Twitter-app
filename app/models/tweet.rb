class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :body, presence: { message: "Comment shouldn't be blank" }
end
