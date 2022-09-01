class Account < ApplicationRecord
  validate :balance_cannot_be_negative

  def give_money(value)
    self.balance = balance + value
  end

  def take_money(value)
    self.balance = balance - value
  end

  def balance_cannot_be_negative
    if balance.negative?
      errors.add(:balance, " can't be negative")
    end
  end


end
