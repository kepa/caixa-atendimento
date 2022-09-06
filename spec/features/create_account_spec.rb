require 'rails_helper'

RSpec.describe 'Creating Account', type: :feature do
  sample_user = User.create(username: 'test', password: 'test')

  scenario 'create an account while logged in' do
    visit login_path
    fill_in 'Username', with: 'test'
    fill_in 'Password', with: 'test'
    click_on 'Login'
    click_on 'Abrir uma nova conta'
    expect(page).to have_content('Conta #')
  end
end
