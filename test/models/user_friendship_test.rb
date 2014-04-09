require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase

	should belong_to(:user)
	should belong_to(:friend)

	test "that creating a friendship works without raising an exception"  do
		assert_nothing_raised do
			UserFriendship.create user: users(:kirushi), friend: users(:carl)
		end
	end

	test "that creating a friendship based on a user id and friend id works" do
	    UserFriendship.create user_id: users(:kirushi).id, friend_id: users(:carl).id
	    assert users(:kirushi).friends.include?(users(:carl))
	end
	
end
