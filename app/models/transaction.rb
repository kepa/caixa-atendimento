# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :account

  validates :value, numericality: { greater_than: 0 }
  validates :fees, numericality: { greater_than_or_equal_to: 0 }
  validates :kind, inclusion: { in: %w[withdraw deposit transfer fee],
                                message: '%<value>s is not a valid kind of transaction' }

  before_validation do
    self.fees = 0 if fees.nil?
  end

  def banking_hours?
    return false if created_at.saturday? || created_at.sunday?

    created_at.hour.between?(9, 18)
  end

  def over_1000?
    value >= 1000
  end

  def calculate_fees
    self.fees = 7
    self.fees = 5 if banking_hours?
    self.fees += 10 if over_1000?
  end

  def collect_fees
    calculate_fees
    account.withdraw(self.fees, 'fee')
  end

  def transaction_date
    "#{created_at.day}/#{created_at.month}/#{created_at.year}"
  end
end
