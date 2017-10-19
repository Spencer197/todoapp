class UsersController < ApplicationController
  
  def index
  @users = User.paginate(page: params[:page], per_page: 5)#Replaces former @users = User.all - Arranges users index data into 5 users per page.
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome #{@user.name} to Todos App!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def show
   @user = User.find(params[:id])
   @user_todos = @user.todos.paginate(page: params[:page], per_page: 5)#defines new instance var @user_todos & paginates user's data.
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])#Find the chef to be deleted.
    @user.destroy#Destroy/delete the selected user
    flash[:danger] = "User & all associated todos have been deleted!"#Display a flash message
    redirect_to users_path#Return to the users listing.
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end

  