require 'test_helper'

class TodosTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(name: "Spencer", email: "spencer@example.com")
    @todo = Todo.create(name: "My Big Plan", description: "I plan to do amazing things!", user: @user)
    @todo2 = @user.todos.build(name: "My Other Big Plan", description: "I'm on my way to greatness!")
    @todo2.save 
  end

  test "should get todos index" do
    get todos_url
    assert_response :success
  end
  
  test "should get todos index listing" do
    get todos_path
    assert_template 'todos/index'
    #assert_match @recipe.name, response.body - replaced by line below.
    assert_select "a[href=?]", todo_path(@todo), text: @todo.name#Asserts that the todo name link should appear in the body on the page.
    #assert_match @tod2.name, response.body - replaced by line below.
    assert_select "a[href=?]", todo_path(@todo2), text: @todo2.name#Asserts that the recipe2 name link should appear in the body on the page.
  end
  
  test "should get todos show page" do
    get todo_path(@todo)
    assert_template 'todos/show'
    assert_match @todo.name, response.body#Checks for recipe name in the body of show page.
    assert_match @todo.description, response.body#Checks for description
    assert_match @user.name, response.body#Checks for user name.
    assert_match 'a[href=?]', edit_todo_path(@todo), text: "Edit this todo"
    assert_select 'a[href=?]', todo_path(@todo), text: "Delete this todo"
    assert_select 'a[href=?]', todos_path, text: "Return to todos listing"
  end

  test "create new valid todo" do
    get new_todo_path
    assert_template 'todos/new'
    name_of_todo = "my plan"
    description_of_todo = "Learn to play guitar, join a rock band, and become a rock star."
    assert_difference 'Todo.count', 1 do
      post todos_path, params: { todo: {name: name_of_todo, description: description_of_todo}} 
    end
    follow_redirect!
    assert_match name_of_todo.capitalize, response.body
    assert_match description_of_todo, response.body
  end
  
  test "reject invalid todo submissions" do
    get new_todo_path
    assert_template 'todos/new'
    assert_no_difference 'Todo.count' do
      post todos_path, params: {todo: {name: " ",description: " "} }#If todo has blank name and description it will be rejected.
    end
    assert_template 'todos/new'#Returns user to the new todo view.
    assert_select 'h1.panel-title'#Shows an error message.
    assert_select 'div.panel-body'#Lists the errors.
  end
end