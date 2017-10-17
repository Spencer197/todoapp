require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
 
  def setup
    @user = User.create!(name: "spencer", email: "spencer@example.com",password: "password", 
                        password_confirmation: "password")
    @todo = Todo.create(name: "Win the lottery", 
        description: "Spend all my money on lottery tickets", 
        user: @user)
    @todo2 = @user.todos.build(name: "Become a rock star", 
                          description: "Learn guitar, join a rock band")
    @todo2.save
  end
  
  test "should get users show page" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select "a[href=?]", todo_path(@todo), text: @todo.name#Ensures that the two links with the todos' titles are present.
    assert_select "a[href=?]", todo_path(@todo2), text: @todo2.name
    assert_match @todo.description, response.body#Ensures that the Todo's description is present.
    assert_match @todo2.description, response.body
    assert_match @user.name, response.body#Ensures that the user's name is present.
  end
end
