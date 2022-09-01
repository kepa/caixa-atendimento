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
      expect(acc.transactions.first.kind).to eql('withdraw')
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
      expect(acc.transactions.first.kind).to eql('deposit')
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

  describe '#deposit as transfer' do

    it 'should create a new transaction of kind transfer' do
      acc = Account.create!(balance: 30.0)
      acc.deposit(20, 'transfer')
      expect(acc.transactions.count).to eql(1)
      expect(acc.transactions.first.kind).to eql('transfer')
    end

  end

  describe '#transfer_out' do

    it 'should take money from self' do
      acc1 = Account.create!(balance: 30.0)
      acc2 = Account.create!
      acc1.transfer_out(20, acc2.id)
      expect(acc1.balance).to eql(10.0)
    end

    it 'should create a transaction on self with kind transfer' do
      acc1 = Account.create!(balance: 30.0)
      acc2 = Account.create!
      acc1.transfer_out(20, acc2.id)
      expect(acc1.transactions.count).to eql(1)
      expect(acc1.transactions.first.kind).to eql('transfer')
    end

    it 'should give money to destination account' do
      acc1 = Account.create!(balance: 30.0)
      acc2 = Account.create!
      acc1.transfer_out(20, acc2.id)
      acc2.save
      expect(acc2.balance).to eql(20.0)
    end

    it 'should create a transaction on destination with kind transfer' do
      acc1 = Account.create!(balance: 30.0)
      acc2 = Account.create!
      acc1.transfer_out(20, acc2.id)
      expect(acc2.transactions.count).to eql(1)
      expect(acc2.transactions.first.kind).to eql('transfer')
    end

  end

end
