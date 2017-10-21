require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
    def setup
    @user = User.create!(name: "spencer", email: "spencer@example.com",  password: "password", 
                       password_confirmation: "password")
    @user2 = USer.create!(name: "John", email: "john@example.com",
                         password: "password", password_confirmation: "password")                  
    @admin_user = User.create!(name: "John1", email: "john1@example.com",
                         password: "password", password_confirmation: "password", admin: true)
    end
  
    test "reject an invalid edit" do
    get edit_user_path(@user)
    assert_template 'user/edit'
    patch user_path(@user), params: { user: { name: " ", email: "spencer@example.com" } }
    assert_template 'users/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
    end
  
    test "accept valid edit" do
    sign_in_as(@user, "password")
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "spencer1", email: "spencer1@example.com" } }
    assert_redirected_to @user#Redirects to the user's show page.
    assert_not flash.empty?
    @user.reload#Reloads the chef's params for edit to take effect.
    assert_match "spencer1", @user.name
    assert_match "spencer1@example.com", @user.email
  end
  
  test "accept edit atempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_user_path(@user)
      patch user_path(@user), params: { user: { name: "Spencer2", email: "spencer2@example.com" } }
    assert_redirected_to @user#Redirects to the chef's show page
    assert_not flash.empty?
    @user.reload#Reloads the user's params for edit to take effect.
    assert_match "Spencer2", @user.name
    assert_match "spencer2@example.com", @user.email
  end
  
  test "redirect edit attempt by non-admin user" do
    sign_in_as(@user2, "password")
    updated_name "joe"#Simulates an attempted edit of Spencer's account by non-admin user.
    updated_email "joe@example.com"
    patch chef_path(@user), params: { user: { name: updated_name, email: updated_email } }
    assert_redirected_to @user#Redirects to the user's show page
    assert_not flash.empty?
    @user.reload#Reloads the user's params for edit to take effect.
    assert_match "Spencer", @user.name
    assert_match "spencer@example.com", @user.email
  end
end
