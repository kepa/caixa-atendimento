# frozen_string_literal: true

class StaticController < ApplicationController
  before_action :set_account, only: %i[deposit withdraw transfer]
  before_action :redirect_to_welcome, only: :home
  skip_before_action :authorized, only: :home

  def home; end

  def deposit; end

  def withdraw; end

  def transfer; end

  private

  def set_account
    @account = Account.find(params[:account])
  end

  def redirect_to_welcome
    redirect_to '/welcome' if logged_in?
  end
end
