require 'test_helper'

class UsersListingTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(name: "spencer", email: "spencer@example.com",
                    password: "password", password_confirmation: "password")
    @user2 = User.create!(name: "john", email: "john@example.com",
                    password: "password", password_confirmation: "password")
  end
  
  test "should get users listing" do
    get users_path
    assert_template 'users/index'
  assert_select "a[href=?]", user_path(@user), text: @user.name.capitalize
  assert_select "a[href=?]", user_path(@user2), text: @user2.name.capitalize
  end

  test "should delete user" do
    sign_in_as(@admin_user, "password")
    get users_path
    assert_template 'users/index'
    assert_difference 'User.count', -1 do
      delete user_path(@user2)#Deletes user2 
    end
    assert_redirected_to users_path
    assert_not flash.empty?
  end
end
