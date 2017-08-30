class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]
  
  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)#Creates new Todo object.
    if@todo.save# Saves form input to the database.
      flash[:notice] = "Todo was created successfully."#Adds a flash message.
      redirect_to todo_path(@todo)# Redirects input to the Todo show page.
    else
      render 'new'#Show the new temmplate again.
    end
  end
  
  def show
    #See def set_todo under private
  end
  
  def edit
    #See def set_todo under private
  end
  
  def update
    #See def set_todo under private
    if @todo.update(todo_params)#Saves/updates form input to the database. If successful,
      flash[:notice] = "Todo was successfully updated."#Adds 'successful' flash message.
      redirect_to todo_path(@todo)#Redirects input to the Todo show page.
    else
      render 'edit'
    end
  end
  
  def index
    @todos = Todo.all
  end
  
  def destroy
    #See def set_todo under private
    @todo.destroy
    flash[:notice] = "Todo was deleted successfully."
    redirect_to todos_path
  end
  
  private
  
  def set_todo
    @todo = Todo.find(params[:id])# Finds a specific Todo object for each of the show, edit, update, & destroy methods.  This line was "extracted away" from these methods.
  end
  
  def todo_params# Adds 'strong parameters' which white lists the kinds of parameters (name, description) recieved from the Todo form.
    params.require(:todo).permit(:name, :description)
  end

end