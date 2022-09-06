class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to '/welcome'
    else
      render :new, status: :unprocessable_entity
    end

  end
end

private

def user_params
  params.require(:user).permit(:username,:password)
end
