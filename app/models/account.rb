class Account < ApplicationRecord
  validate :balance_cannot_be_negative

  has_many :transactions

  def give_money(value)
    self.balance = balance + value if active
  end

  def take_money(value)
    self.balance = balance - value if active
  end

  def withdraw(value)
    take_money(value)
    self.transactions.create(value: value, kind: 'withdraw') if self.valid?
  end

  def deposit(value)
    give_money(value)
    self.transactions.create(value: value, kind: 'deposit') if self.valid?
  end

  def balance_cannot_be_negative
    if balance.negative?
      errors.add(:balance, " can't be negative")
    end
  end


end
