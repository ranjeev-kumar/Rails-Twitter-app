class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy

  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy

  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  VALID_NAME_REGEX = /[a-zA-Z]+/

  validates :fname, presence: true, length: { minimum: 3, too_short: "should be atleast 3 characters long."}, format: { with: VALID_NAME_REGEX }

  validates :lname, presence: true, length: { minimum: 3, too_short: "should be 3 characters long."}, format: { with: VALID_NAME_REGEX }

	validates :dob, presence: true

	validate :is_valid_dob?

	validates :gender, presence: true


  after_create :welcome_user

  private

    def welcome_user
      UserMailer.welcome_email(self).deliver
    end

    def is_valid_dob?
      if((dob.is_a?(Date) rescue ArgumentError) == ArgumentError)
        errors.add(:birthday, ': Sorry, Invalid Date of Birth Entered.')
      end
    end
end
