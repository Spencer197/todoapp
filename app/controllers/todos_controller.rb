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
  
  private
  
  def todo_params# Adds 'strong parameters' which white lists the kinds of parameters (name, description) recieved from the Todo form.
    params.require(:todo).permit(:name, :description)
  end

end