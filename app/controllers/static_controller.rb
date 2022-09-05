class StaticController < ApplicationController
  before_action :set_account, only: %i[ deposit withdraw transfer ]
  skip_before_action :authorized, only: :home

  def home
  end

  def deposit
  end

  def withdraw
  end

  def transfer
  end

  private

  def set_account
    @account = Account.find(params[:account])
  end

end
