# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Statics', type: :request do
  describe 'GET /home' do
    it 'returns http success' do
      get '/static/home'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /deposit' do
    it 'returns http success' do
      get '/static/deposit'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /withdraw' do
    it 'returns http success' do
      get '/static/withdraw'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /transfer' do
    it 'returns http success' do
      get '/static/transfer'
      expect(response).to have_http_status(:success)
    end
  end
end
