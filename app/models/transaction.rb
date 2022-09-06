class Transaction < ApplicationRecord
  belongs_to :account

  validates :value, numericality: { greater_than: 0 }
  validates :fees, numericality: { greater_than_or_equal_to: 0 }
  validates :kind, inclusion: {in: %w(withdraw deposit transfer fee),
    message: "%{value} is not a valid kind of transaction" }

  before_validation do
    self.fees = 0 if self.fees.nil?
  end

  def banking_hours?
    return false if self.created_at.saturday? or self.created_at.sunday?
    self.created_at.hour.between?(9,18)
  end

  def over_1000?
    self.value >= 1000
  end

  def calculate_fees
    self.fees = 7
    self.fees = 5 if self.banking_hours?
    self.fees += 10 if self.over_1000?
  end

  def collect_fees
    self.calculate_fees
    self.account.withdraw(self.fees, 'fee')
  end

  def transaction_date
    return "#{self.created_at.day}/#{self.created_at.month}/#{self.created_at.year}"
  end

end
