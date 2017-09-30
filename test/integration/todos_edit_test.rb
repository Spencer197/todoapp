require 'test_helper'

class TodosEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "Spencer", email: "spencer@example.com")
    @todo = Todo.create(name: "My Big Plan", description: "Learn to trade stocks and options, then retire a millionare before 30.", user: @user)
  end
  
  test "reject invalid todo update" do
    get edit_todo_path(@todo)#Goes to edit recipe path and uses dynamic ID number to find todo to be edited.
    assert_template 'todos/edit'#Asserts/displays the todos edit form template/view.
    patch todo_path(@todo), params: { todo: { name: " ", description: "some description" }}# Attempts to update an invalid todo, but gets rejected. 
    assert_template 'todos/edit'# Returns user to the todos edit template.
    assert_select 'h1.panel-title'#Shows an error message.
    assert_select 'div.panel-body'#Lists the errors.
  end
  
  test "successfully edit a todo" do
    get edit_todo_path(@todo)
    assert_template 'todos/edit'
    updated_name = "updated todo name"
    updated_description = "updated todo description"
    patch todo_path(@todo), params: { todo: { name: updated_name, description: updated_description } }
    assert_redirected_to @todo#Explicitly assert the edited recipe's show page.  @recipe means the recipe show page. 
    #follow redirect! #This is how we redirected to the recipe's show page for the create action
    assert_not flash.empty?#Checks that the flash message is not empty.
    @todo.reload#Reloads to edited version of the recipe.
    assert_match updated_name, @todo.name#These assert_match lines show an alternative to the 'response.body' assert_match in recipes_test. 
    assert_match updated_description, @todo.description
  end
end

  
  