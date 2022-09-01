class Account < ApplicationRecord

  #attr_accessor :balance, :active

  before_create do
    self.balance = 0.0
    self.active = true
  end

  def give_money(value)
    raise 'Somente valores positivos' if value < 0
    self.balance += value
  end

  def take_money(value)
    raise 'Saldo não pode ser negativo' if balance - value < 0
    self.balance = balance - value
  end

end
