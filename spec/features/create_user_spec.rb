require 'rails_helper'

RSpec.describe 'Creating an user', type: :feature do
  scenario 'valid creation' do
    visit root_path
    click_on 'Cadastrar-se'
    fill_in 'Username', with: 'test'
    fill_in 'Password', with: 'test'
    click_on 'Create User'
    expect(page).to have_content('Bem-vindo test!')
  end
end
