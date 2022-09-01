require 'rails_helper'

RSpec.describe Account, type: :model do

  describe '#give_money' do

    it 'should add money to balance' do
      acc = Account.create!
      acc.give_money(20)
      expect(acc.balance).to eql(20.0)
    end

    it 'should be invalid if balance gets negative' do
      acc = Account.create!
      acc.give_money(-20)
      expect(acc.invalid?).to eql(true)
    end

    it 'should only give money if Account is active' do
      acc = Account.create!(active: false)
      acc.give_money(20)
      expect(acc.balance).to eql(0.0)
    end

  end

  describe '#take_money' do

    it 'should remove money from balance' do
      acc = Account.create!(balance: 30.0)
      acc.take_money(10)
      expect(acc.balance).to eql(20.0)
    end

    it 'should be invalid if balance gets negative' do
      acc = Account.create!(balance: 30.0)
      acc.take_money(40)
      expect(acc.invalid?).to eql(true)
    end

    it 'should only take money if Account is active' do
      acc = Account.create!(balance: 30.0, active: false)
      acc.take_money(20)
      expect(acc.balance).to eql(30.0)
    end

  end

  describe '#withdraw' do

    it 'should create a new transaction of kind withdraw' do
      acc = Account.create!(balance: 30.0)
      acc.withdraw(20)
      expect(acc.transactions.count).to eql(1)
    end

    it 'should decrease the current account balance' do
      acc = Account.create!(balance: 30.0)
      acc.withdraw(20)
      expect(acc.balance).to eql(10.0)
    end

    it 'should handle account balance errors' do
      acc = Account.create!(balance: 30.0)
      acc.withdraw(40)
      expect(acc.invalid?).to eql(true)
      expect(acc.transactions.count).to eql(0)
    end

  end

  describe '#deposit' do

    it 'should create a new transaction of kind deposit' do
      acc = Account.create!(balance: 30.0)
      acc.deposit(20)
      expect(acc.transactions.count).to eql(1)
    end

    it 'should increase the current account balance' do
      acc = Account.create!(balance: 30.0)
      acc.deposit(20)
      expect(acc.balance).to eql(50.0)
    end

    it 'should handle account balance errors' do
      acc = Account.create!(balance: 30.0)
      acc.deposit(-40)
      expect(acc.invalid?).to eql(true)
      expect(acc.transactions.count).to eql(0)
    end
  end

end
