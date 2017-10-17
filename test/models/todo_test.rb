require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  
  def setup
    @user = User.create!(name: "Spencer", email: "spencer@example.com",
                        password: "password", password_confirmation: "password")#These lines create a user with email & password.
    @todo = @user.todos.build(name: "My Big Plan", description: "This plan is awesome!")#Replaces line below to assign a user to a new todo. The build method automtically adds the user_id to the todo.
    #@todo = Todo.new(name: "My Big Plan", description: "This plan is awesome!")#Simply creates a new todo.
  end
  
  test "todo without user id should be invalid" do
    @todo.user_id = nil
    assert_not @todo.valid?
  end
  
  test "todo should be valid" do
    assert @todo.valid?
  end
  
  test "name should be present" do
    @todo.name = " "
    assert_not @todo.valid?
  end
  
  test "description should be present" do
    @todo.description = " "
    assert_not @todo.valid?
  end
  
  test "Description shouldn't be less than 5 characters." do
    @todo.description = "a" * 4
    assert_not @todo.valid?
  end

  test "Description shouldn't be more than 10000 characters." do
    @todo.description = "a" * 10001
    assert_not @todo.valid?
  end
end