class TodosController < ApplicationController
  
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
    @todo = Todo.find(params[:id])#Finds a specific Todo entry.
  end
  
  def edit
    @todo = Todo.find(params[:id])
  end
  
  def update
   @todo = Todo.find(params[:id])#Creates a new Todo object.
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
    @todo = Todo.find(params[:id])
    @todo.destroy
    flash[:notice] = "Todo was deleted successfully."
    redirect_to todos_path
  end
  
  private
  
  def todo_params# Adds 'strong parameters' which white lists the kinds of parameters (name, description) recieved from the Todo form.
    params.require(:todo).permit(:name, :description)
  end

end