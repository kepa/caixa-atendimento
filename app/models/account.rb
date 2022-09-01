class Account < ApplicationRecord
  validate :balance_cannot_be_negative, on: :update


  before_create do
    self.balance = 0.0
    self.active = true
  end

  def give_money(value)
    self.update(balance: balance + value)
  end

  def take_money(value)
    self.update(balance: balance - value)
  end

  def balance_cannot_be_negative
    if balance.negative?
      errors.add(:balance, " can't be negative")
    end
  end


end
