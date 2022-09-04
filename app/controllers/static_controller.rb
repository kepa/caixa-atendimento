class StaticController < ApplicationController
  before_action :set_account, only: %i[ deposit withdraw transfer ]


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
