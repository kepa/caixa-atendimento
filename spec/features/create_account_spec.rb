# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Creating Account', type: :feature do
  sample_user = User.create(username: 'test', password: 'test')

  it 'create an account while logged in' do
    visit login_path
    fill_in 'Seu nome:', with: 'test'
    fill_in 'Sua senha:', with: 'test'
    click_on 'Login'
    click_on 'Abrir uma nova conta'
    expect(page).to have_content('Conta #')
  end
end
