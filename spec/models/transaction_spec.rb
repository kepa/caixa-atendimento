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

    let(:account) {Account.create}
    let(:transaction) {account.transactions.create(value: 30,kind: "transfer")}
    let(:transaction_over1000) {account.transactions.create(value: 1000,kind: "transfer")}
    let(:banking_hours) {Time.new(2022,9,01,10,00,59)}
    let(:non_banking_hours) {Time.new(2022,9,01,06,00,59)}
    let(:weekend) {Time.new(2022,9,03,06,00,59)}

    describe '#banking_hours?' do

      it 'should return true within banking hours' do
        transaction.update(created_at: banking_hours)
        expect(transaction.banking_hours?).to eql(true)
      end

      it 'should return false out banking hours' do
        transaction.update(created_at: non_banking_hours)
        expect(transaction.banking_hours?).to eql(false)
      end

      it 'should return false on weekend' do
        transaction.update(created_at: weekend)
        expect(transaction.banking_hours?).to eql(false)
      end

    end

    describe '#over_1000?' do

      it 'should return true if value over 1000' do
        expect(transaction_over1000.over_1000?).to eql(true)
      end

    end

    describe '#calculate_fees' do

      it 'should return 5 if within banking hours' do
        transaction.update(created_at: banking_hours)
        transaction.calculate_fees
        expect(transaction.fees).to eql(5.0)
      end

      it 'should return 7 if out banking hours' do
        transaction.update(created_at: non_banking_hours)
        transaction.calculate_fees
        expect(transaction.fees).to eql(7.0)
      end

      it 'should return 15 if within banking hours and over 1000' do
        transaction_over1000.update(created_at: banking_hours)
        transaction_over1000.calculate_fees
        expect(transaction_over1000.fees).to eql(15.0)
      end

      it 'should return 17 if out banking hours and over 1000' do
        transaction_over1000.update(created_at: non_banking_hours)
        transaction_over1000.calculate_fees
        expect(transaction_over1000.fees).to eql(17.0)
      end

    end

  end

end
