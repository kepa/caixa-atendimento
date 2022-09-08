# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  describe '#give_money' do
    it 'adds money to balance' do
      acc = described_class.create!
      acc.give_money(20)
      expect(acc.balance).to be(20.0)
    end

    it 'is invalid if balance gets negative' do
      acc = described_class.create!
      acc.give_money(-20)
      expect(acc.invalid?).to be(true)
    end

    it 'onlies give money if Account is active' do
      acc = described_class.create!(active: false)
      acc.give_money(20)
      expect(acc.balance).to be(0.0)
    end
  end

  describe '#take_money' do
    it 'removes money from balance' do
      acc = described_class.create!(balance: 30.0)
      acc.take_money(10)
      expect(acc.balance).to be(20.0)
    end

    it 'is invalid if balance gets negative' do
      acc = described_class.create!(balance: 30.0)
      acc.take_money(40)
      expect(acc.invalid?).to be(true)
    end

    it 'onlies take money if Account is active' do
      acc = described_class.create!(balance: 30.0, active: false)
      acc.take_money(20)
      expect(acc.balance).to be(30.0)
    end
  end

  describe '#withdraw' do
    it 'creates a new transaction of kind withdraw' do
      acc = described_class.create!(balance: 30.0)
      acc.withdraw(20)
      expect(acc.transactions.count).to be(1)
      expect(acc.transactions.first.kind).to eql('withdraw')
    end

    it 'decreases the current account balance' do
      acc = described_class.create!(balance: 30.0)
      acc.withdraw(20)
      expect(acc.balance).to be(10.0)
    end

    it 'handles account balance errors' do
      acc = described_class.create!(balance: 30.0)
      acc.withdraw(40)
      expect(acc.invalid?).to be(true)
      expect(acc.transactions.count).to be(0)
    end
  end

  describe '#deposit' do
    it 'creates a new transaction of kind deposit' do
      acc = described_class.create!(balance: 30.0)
      acc.deposit(20)
      expect(acc.transactions.count).to be(1)
      expect(acc.transactions.first.kind).to eql('deposit')
    end

    it 'increases the current account balance' do
      acc = described_class.create!(balance: 30.0)
      acc.deposit(20)
      expect(acc.balance).to be(50.0)
    end

    it 'handles account balance errors' do
      acc = described_class.create!(balance: 30.0)
      acc.deposit(-40)
      expect(acc.invalid?).to be(true)
      expect(acc.transactions.count).to be(0)
    end
  end

  describe '#deposit as transfer' do
    it 'creates a new transaction of kind transfer' do
      acc = described_class.create!(balance: 30.0)
      acc.deposit(20, 'transfer')
      expect(acc.transactions.count).to be(1)
      expect(acc.transactions.first.kind).to eql('transfer')
    end
  end

  describe '#transfer_out' do
    it 'takes money from self' do
      acc1 = described_class.create!(balance: 30.0)
      acc2 = described_class.create!
      acc1.transfer_out(20, acc2)
      expect(acc1.balance).to be(5.0)
    end

    it 'creates a transaction on self with kind transfer' do
      acc1 = described_class.create!(balance: 30.0)
      acc2 = described_class.create!
      acc1.transfer_out(20, acc2)
      expect(acc1.transactions.count).to be(2)
      expect(acc1.transactions.first.kind).to eql('transfer')
    end

    it 'gives money to destination account' do
      acc1 = described_class.create!(balance: 30.0)
      acc2 = described_class.create!
      acc1.transfer_out(20, acc2)
      expect(acc2.balance).to be(20.0)
    end

    it 'creates a transaction on destination with kind transfer' do
      acc1 = described_class.create!(balance: 30.0)
      acc2 = described_class.create!
      acc1.transfer_out(20, acc2)
      expect(acc2.transactions.count).to be(1)
      expect(acc2.transactions.first.kind).to eql('transfer')
    end
  end
end
