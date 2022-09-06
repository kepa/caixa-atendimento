require 'rails_helper'

RSpec.describe 'Running all major transactions', type: :feature do
  sample_user = User.create(username: 'test', password: 'test')

  scenario 'create an account and deposit money' do
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

  scenario 'create an account, deposit and withdraw money' do
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

end
