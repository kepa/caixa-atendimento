class Account < ApplicationRecord
  validate :balance_cannot_be_negative

  has_many :transactions

  def update(params)
    deposit(params[:deposit_value].to_f) unless params[:deposit_value].nil?
    withdraw(params[:withdraw_value].to_f) unless params[:withdraw_value].nil?
    transfer_out(params[:transfer_value].to_f, Account.find(params[:dest_account].to_f)) unless params[:transfer_value].nil? and params[:dest_account].nil?
  end

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
    destination_account.save
  end

  def historic_statement(initial_date, end_date)
    self.transactions.where(created_at: Date.parse(initial_date)..(Date.parse(end_date) + 1.day))
  end

  def balance_cannot_be_negative
     errors.add(:balance, " can't be negative") if balance.negative?
  end

  def value_cannot_be_empty(value)
    errors.add(:value, " can't be empty") if value.empty?
    value.empty?
  end

  def dest_account_cannot_be_empty(value)
    errors.add(:destination_account, " can't be empty") if value.empty?
    value.empty?
  end
end
