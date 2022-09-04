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

  def update

    msg = "Saque realizado com sucesso"
    #@account.deposit(account_params[:deposit_value].to_f)
    @account.update(account_params)

    if @account.save
      redirect_to account_url(@account), notice: msg
    end
  end

  def destroy
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:withdraw_value,:deposit_value,:transfer_value,:dest_account)
  end

end
