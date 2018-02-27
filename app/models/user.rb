class User < ApplicationRecord
  has_secure_password

  has_many :tasks
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates_format_of :email, with: VALID_EMAIL_REGEX
  validates_uniqueness_of :email
end
