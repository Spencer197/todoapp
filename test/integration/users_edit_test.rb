require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
    def setup
    @user = User.create!(name: "spencer1", email: "spencer1@example.com",  password: "password", 
                       password_confirmation: "password")
    end
  
    test "reject an invalid edit" do
    get edit_user_path(@user)
    assert_template 'user/edit'
    patch user_path(@user), params: { user: { name: " ", 
                              email: "spencer@example.com" } }
    assert_template 'users/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
    end
  
    test "accept valid signup" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "spencer1", 
                                email: "spencer1@example.com" } }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match "spencer1", @user.name
    assert_match "spencer1@example.com", @user.email
  end
end
