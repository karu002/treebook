require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "a user should enter a first name" do 
  	user = User.new
  	assert !user.save #user should not be saved in the database
  	assert !user.errors[:first_name].empty? # errors on first_name field are not empty
  end

  test "a user should enter a last name" do 
  	user = User.new
  	assert !user.save #user should not be saved in the database
  	assert !user.errors[:first_name].empty? # errors on last_name field are not empty
  end

  test "a user should enter a profile name" do 
  	user = User.new
  	assert !user.save #user should not be saved in the database
  	assert !user.errors[:profile_name].empty? # errors on profile_name field are not empty
  end

  test "a user should have a unique profile name" do
  	user = User.new
  	user.profile_name = users(:kirushi).profile_name
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
    user = User.new(first_name: 'kirushi', last_name: 'sothy', email: 'kirushi.a@outlook.com')
    user.password = user.password_confirmation = 'helloworld'
    
  	user.profile_name = "My Profile With Spaces"

  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  	assert user.errors[:profile_name].include?("must be formatted correctly.")
  end

  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'kirushi', last_name: 'sothy', email: 'kirushi.a@outlook.com')
    user.password = user.password_confirmation = 'helloworld'

    user.profile_name = "kirushia"
    assert !user.valid?
  end

end
