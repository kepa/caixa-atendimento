class Transaction < ApplicationRecord
  belongs_to :account

  validates :value, numericality: { greater_than: 0 }
  validates :fees, numericality: { greater_than_or_equal_to: 0 }
  validates :kind, inclusion: {in: %w(withdraw deposit transfer),
    message: "%{value} is not a valid kind of transaction" }

  before_validation do
    self.fees = 0 if self.fees.nil?
  end

end
