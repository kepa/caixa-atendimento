class Transaction < ApplicationRecord
  belongs_to :account

  validates :value, numericality: { greater_than: 0 }
  validates :fees, numericality: { greater_than: 0 }
  validates :kind, inclusion: {in: %w(withdraw deposit transfer),
    message: "%{value} is not a valid kind of transaction" }

end
