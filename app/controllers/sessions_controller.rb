class SessionsController < ApplicationController
  
  def new
  # will simply render the form
  end

  def create# Handles the form submission, creates the session, & moves user to a logged in state.
    user = User.find_by(email: params[:session][:email].downcase)#Finds user by email.
  if user && user.authenticate(params[:session][:password])
    session[:user_id] = user.id
    cookies.signed[:user_id] = user.id#Saves the encrypted user_id in the cookies; not just in the session hash only.
    flash[:success] = "You have successfully logged in."
    redirect_to user
  else
    flash.now[:danger] = "There was something wrong with your login information."#This flash is needed here because a session is not a model based resource, so the error partial is not availabe for this action.
    render 'new'
  end
  end

  def destroy# Handles the logout. Ends the session or simulates a logged out state.
    session[:user_id] = nil
    flash[:success] = "You have logged out."
    redirect_to root_path
  end

end 