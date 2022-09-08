# frozen_string_literal: true

class User < ApplicationRecord
  validates :username, presence: true

  has_secure_password

  has_many :accounts
end
