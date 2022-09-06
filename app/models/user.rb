class User < ApplicationRecord
  validates_presence_of :username

  has_secure_password

  has_many :accounts

end
