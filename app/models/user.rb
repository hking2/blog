class User < ApplicationRecord
  before_save { self.email = email.downcase }
  #relations to other objects
  has_many :articles
  #validates :attribute-name, require-this: true
  validates :username, 
    presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, 
    presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX }
  has_secure_password
end