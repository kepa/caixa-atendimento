# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'basic validation' do
    describe 'value' do
      it 'onlies be positive' do
        acc = Account.create
        trans = acc.transactions.create(value: -30, fees: 30, kind: 'withdraw')
        expect(trans.invalid?).to be(true)
      end
    end

    describe 'fee' do
      it 'onlies be positive' do
        acc = Account.create
        trans = acc.transactions.create(value: 30, fees: -30, kind: 'withdraw')
        expect(trans.invalid?).to be(true)
      end
    end

    describe 'kind' do
      it 'onlies be withdraw, deposit or transfer' do
        acc = Account.create
        trans = acc.transactions.create(value: 30, fees: 30, kind: 'test')
        expect(trans.invalid?).to be(true)
      end
    end
  end

  context 'fee calculation' do
    let(:account) { Account.create(balance: 50) }
    let(:transaction) { account.transactions.create(value: 30, kind: 'transfer') }
    let(:transaction_over1000) { account.transactions.create(value: 1000, kind: 'transfer') }
    let(:banking_hours) { Time.zone.local(2022, 9, 0o1, 10, 0o0, 59) }
    let(:non_banking_hours) { Time.zone.local(2022, 9, 0o1, 0o6, 0o0, 59) }
    let(:weekend) { Time.zone.local(2022, 9, 0o3, 0o6, 0o0, 59) }

    describe '#banking_hours?' do
      it 'returns true within banking hours' do
        transaction.update(created_at: banking_hours)
        expect(transaction.banking_hours?).to be(true)
      end

      it 'returns false out banking hours' do
        transaction.update(created_at: non_banking_hours)
        expect(transaction.banking_hours?).to be(false)
      end

      it 'returns false on weekend' do
        transaction.update(created_at: weekend)
        expect(transaction.banking_hours?).to be(false)
      end
    end

    describe '#over_1000?' do
      it 'returns true if value over 1000' do
        expect(transaction_over1000.over_1000?).to be(true)
      end
    end

    describe '#calculate_fees' do
      it 'returns 5 if within banking hours' do
        transaction.update(created_at: banking_hours)
        transaction.calculate_fees
        expect(transaction.fees).to be(5.0)
      end

      it 'returns 7 if out banking hours' do
        transaction.update(created_at: non_banking_hours)
        transaction.calculate_fees
        expect(transaction.fees).to be(7.0)
      end

      it 'returns 15 if within banking hours and over 1000' do
        transaction_over1000.update(created_at: banking_hours)
        transaction_over1000.calculate_fees
        expect(transaction_over1000.fees).to be(15.0)
      end

      it 'returns 17 if out banking hours and over 1000' do
        transaction_over1000.update(created_at: non_banking_hours)
        transaction_over1000.calculate_fees
        expect(transaction_over1000.fees).to be(17.0)
      end
    end

    describe '#collect_fees' do
      it 'withdraws money from original account' do
        transaction.update(created_at: banking_hours)
        transaction.collect_fees
        expect(account.balance).to be(45.0)
      end
    end
  end
end
