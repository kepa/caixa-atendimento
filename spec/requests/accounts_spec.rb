require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/accounts/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/accounts/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/accounts/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/accounts/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/accounts/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
