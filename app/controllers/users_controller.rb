class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  def index
  @users = User.paginate(page: params[:page], per_page: 5)#Replaces former @users = User.all - Arranges users index data into 5 users per page.
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id#Logs in a new user as soon as he/she signs up for a new account.
      cookies.signed[:user_id] = @user.id#Stores user_id in cookies.
      flash[:success] = "Welcome #{@user.name} to Todos App!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def show
   #@user = User.find(params[:id]) - See set_user under private
   @user_todos = @user.todos.paginate(page: params[:page], per_page: 5)#defines new instance var @user_todos & paginates user's data.
  end
  
  def edit
    #@user = User.find(params[:id]) - See set_user under private
  end
  
  def update
   # @user = User.find(params[:id]) - See set_user under private
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    #@user = User.find(params[:id])#Find the chef to be deleted. - See set_user under private
    if !@user.admin?
    @user.destroy#Destroy/delete the selected user
    flash[:danger] = "User & all associated todos have been deleted!"#Display a flash message
    redirect_to users_path#Return to the users listing.
    end
  end  

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def require_same_user
    if current_user != @user and !current_user.admin?#Requires user to be logged in to alter one's own account or be admin. 
      flash[:danger] = "You can only edit and delete your own account."
      redirect_to user_path
    end
  end
  
  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = "Only admin users can perform that action."
      redirect_to root_path
    end
  end

end

  