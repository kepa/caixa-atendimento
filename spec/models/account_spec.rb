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

    it 'should not take negative values' do

    end

  end

  describe '#take_money' do

    it 'should remove money from balance' do
      acc = Account.create!
      acc.give_money(20)
      acc.take_money(10)
      expect(acc.balance).to eql(10.0)
    end

    it 'should be invalid if balance gets negative' do
      acc = Account.create!
      acc.give_money(20)
      acc.take_money(30)
      expect(acc.invalid?).to eql(true)
    end

  end

end
