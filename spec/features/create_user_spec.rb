# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Creating an user', type: :feature do
  it 'valid creation' do
    visit root_path
    click_on 'Cadastrar-se'
    fill_in 'Seu nome:', with: 'test'
    fill_in 'Sua senha:', with: 'test'
    click_on 'Concluir cadastro'
    expect(page).to have_content('Bem-vindo test!')
  end
end
