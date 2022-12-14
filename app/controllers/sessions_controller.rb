# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorized, only: %i[new create welcome]

  def new; end

  def create
    @user = User.find_by(username: params[:username])

    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/welcome'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def login; end

  def welcome
    @accounts = current_user.accounts
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
