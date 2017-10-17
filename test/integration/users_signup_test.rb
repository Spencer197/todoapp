require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "Should get signup path" do
    get signup_path
    assert_response :success
  end
  
  test "reject an invalid signup" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: { user: { name: " ", email: " ", password: "password ",
                                password_confirmation: " " } }
    end
    assert_template 'users/new'#Shows signup form again
    assert_select 'h2.panel-title'#Calls error messages partial
    assert_select 'div.panel-body'#Call the panel html for error messages
  end
  
  test "accept a vaild signup" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "Spencer ", email: "spencer@example.com ", password: "password ",
                                password_confirmation: "password" } }
    end
    follow_redirect!#Redirects user on successful signup
    assert_select 'users/show'#Goes to user's profile page - chefs/show
    assert_not flash.empty?#Assert that the successful flash message appears.
  end
end
