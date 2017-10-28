# This model provides all the getters and setters for the name and email attributes.
class User < ApplicationRecord
  before_save { self.email = email.downcase }#converts email to lower case letters before saving.
  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false }
  has_many :todos, dependent: :destroy#Asserts that User class can have many todos associated with it. "dependent: :destroy" ensure that all of a user's todos are destroyed with the user.
  has_secure_password
  validates :password, presence: true, length: { minimum: 5 }, allow_nil: true
  has_many :comments, dependent: :destroy
end
