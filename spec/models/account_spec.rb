require 'rails_helper'

RSpec.describe Account, type: :model do

  describe '#give_money' do

    it 'should add money to balance' do
      acc = Account.create!
      acc.give_money(20)
      expect(acc.balance).to eql(20.0)
    end

    it 'should raise execption with negative values' do
      acc = Account.create!
      acc.give_money(-20)
      expect(acc.balance).to eql(0.0)
    end

  end

  describe '#take_money' do

    it 'should remove money from balance' do
      acc = Account.create!
      acc.give_money(20)
      acc.take_money(10)
      expect(acc.balance).to eql(10.0)
    end

  end

end
