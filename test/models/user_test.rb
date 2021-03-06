require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
  @user = User.new(name: "Spencer", email: "spencer@example.com", 
                  password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end
  
  test "Name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end
  
  test "Name should be less than 30 characters." do
    @user.name = "a" * 31
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end
  
  test "email should not exceed 255 characters" do
    @user.email = "a" * 245 + "@example.com"#This sums to more than 255.
    assert_not @user.valid?
  end
  
  test "email should accept correct format" do
    valid_emails = %w[user@example.com SPENCER@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |valids|
      @user.email = valids
      assert @user.valid?, "#{valids.inspect} should be valid"
    end
  end
  
  test "should reject invalid email addresses" do
    invalid_emails = %w[john@example john@example,com john.name@gmail joe@bar+foo.com]
    invalid_emails.each do |invalids|
      @user.email = invalids
      assert_not @user.valid?, "#{invalids.inspect} should be invalid"
    end
  end
  
  test "email should be unique and case insensitive" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email should be lower case before hitting db" do
    mixed_email = "JohN@example.com"
    @user.email = mixed_email
    @user.save
    assert_equal mixed_email.downcase, @user.reload.email
  end
  
   test "password should be present" do
    @user.password = @user.password_confirmation = " "
    assert_not @user.valid?
  end
  
   test "password should be atleast 5 characters" do
    @user.password = @user.password_confirmation = "x" * 4
    assert_not @user.valid?
  end
  
  test "Associated recipes should be destroyed" do
    @user.save#Associates an id with the user
    @user.todos.create!(name: "testing destroy", description: "Testing destroy function")#Enters todos' names & descriptions into db.
    assert_difference 'Todo.count', -1 do
      @user.destroy
    end
  end
end
    