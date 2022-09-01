class Account < ApplicationRecord
  validate :balance_cannot_be_negative

  has_many :transactions

  def give_money(value)
    self.balance = balance + value if active
  end

  def take_money(value)
    self.balance = balance - value if active
  end

  def balance_cannot_be_negative
    if balance.negative?
      errors.add(:balance, " can't be negative")
    end
  end


end
