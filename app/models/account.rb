class Account < ApplicationRecord
  validate :balance_cannot_be_negative

  has_many :transactions

  def give_money(value)
    self.balance = balance + value if active
  end

  def take_money(value)
    self.balance = balance - value if active
  end

  def withdraw(value, kind='withdraw')
    self.take_money(value)
    self.transactions.create(value: value, kind: kind) if self.valid?
  end

  def deposit(value, kind='deposit')
    self.give_money(value)
    self.transactions.create(value: value, kind: kind) if self.valid?
  end

  def transfer_out(value, destination_account)
    self.withdraw(value, 'transfer')
    self.transactions[self.transactions.count-1].collect_fees
    destination_account.deposit(value, 'transfer') if self.valid?
  end

  def balance_cannot_be_negative
    if balance.negative?
      errors.add(:balance, " can't be negative")
    end
  end


end
