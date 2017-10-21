require 'test_helper'

class TodosDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "Spencer", email: "spencer@example.com",
                        password: "password", password_confirmation: "password")
    @todo = Todo.create(name: "My Big Plan", description: "Learn to trade stocks and options, then retire a millionare before 30.", user: @user)
  end
  
  test "successfully delete a todo" do
    sign_in_as(@user, "password")
    get todo_path(@todo)#Go to show todos page.
    assert_template 'todos/show'#Check that show page is displayed.
    assert_select 'a[href=?]', todo_path(@todo), text: "Delete this Todo"#Checks that 'Delete' button appears in show todos page.
    assert_difference 'Todo.count', -1 do#Checks that the todo count in database is reduced by 1.
      delete todo_path(@todo)#Checks that delete action is requested for todo_path @todo.  
  end
  assert_redirected_to todos_path#Go to todos listing (index).
  assert_not flash.empty?#Checks that the flash message is not empty and appears.
  end
end
