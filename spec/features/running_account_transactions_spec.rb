# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Running all major transactions', type: :feature do
  sample_user = User.create(username: 'test', password: 'test')

  it 'create an account and deposit money' do
    visit login_path
    fill_in 'Username', with: 'test'
    fill_in 'Password', with: 'test'
    click_on 'Login'
    click_on 'Abrir uma nova conta'
    click_on 'Depositar'
    fill_in 'account[deposit_value]', with: '40'
    click_on 'Update Account'
    expect(page).to have_content('Saldo atual: R$ 40.0')
    expect(page).to have_content('deposit')
  end

  it 'create an account, deposit and withdraw money' do
    visit login_path
    fill_in 'Username', with: 'test'
    fill_in 'Password', with: 'test'
    click_on 'Login'
    click_on 'Abrir uma nova conta'
    click_on 'Depositar'
    fill_in 'account[deposit_value]', with: '40'
    click_on 'Update Account'
    click_on 'Sacar'
    fill_in 'account[withdraw_value]', with: '20'
    click_on 'Update Account'
    expect(page).to have_content('Saldo atual: R$ 20.0')
    expect(page).to have_content('deposit')
    expect(page).to have_content('withdraw')
  end

  it 'create an account, deposit and transfer money' do
    visit login_path
    fill_in 'Username', with: 'test'
    fill_in 'Password', with: 'test'
    click_on 'Login'
    click_on 'Abrir uma nova conta'
    visit welcome_path
    click_on 'Abrir uma nova conta'
    click_on 'Depositar'
    fill_in 'account[deposit_value]', with: '40'
    click_on 'Update Account'
    click_on 'Transferir'
    fill_in 'account[transfer_value]', with: '20'
    fill_in 'account[dest_account]', with: Account.first.id
    click_on 'Transferir'
    expect(page).to have_content('transfer')
    expect(page).to have_content('fee')
  end
end
