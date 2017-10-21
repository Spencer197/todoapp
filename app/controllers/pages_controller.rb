class PagesController < ApplicationController
  
  def home
    redirect_to todos_path if logged_in? #If user logged in, todos becomes the home page.
  end
  
  def about
    
  end
  
  def help
    
  end
  
end