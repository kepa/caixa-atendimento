# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Logging-in an user', type: :feature do
  User.create(username: 'test', password: 'test')

  it 'valid login' do
    visit login_path
    fill_in 'Seu nome:', with: 'test'
    fill_in 'Sua senha:', with: 'test'
    click_on 'Login'
    expect(page).to have_content('Bem-vindo test!')
  end
end
