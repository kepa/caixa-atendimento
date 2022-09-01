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

end
