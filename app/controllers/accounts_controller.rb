class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy ]

  def index
    @accounts = Account.all
  end

  def show
  end

  def create
    @account = Account.new

    if @account.save
      redirect_to account_url(@account)
    end
  end

  def edit
  end

  def destroy
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:withdraw,:deposit,:transfer)
  end

end
