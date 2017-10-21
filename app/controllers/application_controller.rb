class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
   helper_method :current_user, :logged_in?#Makes these methods helper methods so they are available to the views.
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]#Returns the current chef's id or (||) Finds chef_id only if user is loged in. - Chef_id is stored in browser's cookie so that db hits are avoided.
  end
  
  def logged_in?
    !!current_user# !! makes current_use a boolean expression.
  end
  
  def require_user
    if !logged_in?# "If not (!) logged in..."
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end
