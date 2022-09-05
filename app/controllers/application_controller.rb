class ApplicationController < ActionController::Base

helper_method :current_user
helper_method :logged_in?
before_action :authorized

def current_user
   User.find_by(id:session[:user_id])
end

def logged_in?
    !current_user.nil?
end

def authorized
   flash[:notice] = "Você precisa estar logado!"
   redirect_to root_path unless logged_in?
end

end
