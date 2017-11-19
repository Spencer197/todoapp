class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @todos = Todo.paginate(page: params[:page], per_page: 5)
    #@todos = Todo.all - Replaced by the line above.
  end
  
  def show
    #See def set_todo under private
    @comment = Comment.new
    @comments = @todo.comments.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)#Creates new Todo object.
    @todo.user = current_user# Replaces: @todo.user = User.first - Assigns current_user as creator of a todo.
    if@todo.save# Saves form input to the database.
      flash[:success] = "Todo was created successfully."#Adds a flash message.
      redirect_to todo_path(@todo)# Redirects input to the Todo show page.
    else
      render 'new'#Show the new template again.
    end
  end
  
  def edit
    #See def set_todo under private
  end
  
  def update
    #See def set_todo under private
    if @todo.update(todo_params)#Saves/updates form input to the database. If successful,
      flash[:success] = "Todo was successfully updated."#Adds 'successful' flash message.
      redirect_to todo_path(@todo)#Redirects input to the Todo show page.
    else
      render 'edit'
    end
  end
  
  def destroy
    #See def set_todo under private
    @todo.destroy
    flash[:success] = "Todo was deleted successfully."
    redirect_to todos_path
  end
  
  private
  
  def set_todo
    @todo = Todo.find(params[:id])# Finds a specific Todo object for each of the show, edit, update, & destroy methods.  This line was "extracted away" from these methods.
  end
  
  def todo_params# Adds 'strong parameters' which white lists the kinds of parameters (name, description) recieved from the Todo form.
    params.require(:todo).permit(:name, :description, factor_ids:[])
  end
  
  def require_same_user
    if current_user != @todo.user and !current_user.admin?
      flash[:danger] = "You can only edit and delete your own recipes."
      redirect_to todos_path
    end
  end
end