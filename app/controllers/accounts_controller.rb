class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy ]

  def index
    @accounts = Account.all
  end

  def show
  end

  def create
    @account = current_user.accounts.new

    if @account.save
      redirect_to account_url(@account)
    end
  end

  def edit
  end

  def update

    @account.update(account_params)

    if @account.save
      redirect_to account_url(@account)
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    @account.active = false

    if @account.save
      redirect_to welcome_path
    else
      render :show, status: :unprocessable_entity
    end

  end

  private

  def set_account
    @account = current_user.accounts.find(params[:id])

    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Acesso negado"
      redirect_to root_path

  end

  def account_params
    params.require(:account).permit(:withdraw_value,:deposit_value,:transfer_value,:dest_account)
  end

end
