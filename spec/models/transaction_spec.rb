require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'basic validation' do

    describe 'value' do

      it 'should only be positive' do
        acc = Account.create
        trans = acc.transactions.create(value: -30,fees: 30,kind: "withdraw")
        expect(trans.invalid?).to eql(true)
      end

    end

    describe 'fee' do

      it 'should only be positive' do
        acc = Account.create
        trans = acc.transactions.create(value: 30,fees: -30,kind: "withdraw")
        expect(trans.invalid?).to eql(true)
      end

    end

    describe 'kind' do

      it 'should only be withdraw, deposit or transfer' do
        acc = Account.create
        trans = acc.transactions.create(value: 30,fees: 30,kind: "test")
        expect(trans.invalid?).to eql(true)
      end

    end
  end

  context 'fee calculation' do

  end

end
