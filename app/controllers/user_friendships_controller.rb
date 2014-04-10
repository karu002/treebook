class UserFriendshipsController < ApplicationController

	before_filter :authenticate_user!, only: [:new]

	def new
		if params[:friend_id]
			@friend = User.where(profile_name: params[:friend_id]).first
			raise ActiveRecord::RecordNotFound if @friend.nil?
			@user_friendship = current_user.user_friendships.new(friend: @friend)
		else
			flash[:error] = "Friend required"
		end
	rescue ActiveRecord::RecordNotFound
		render file: 'public/404', status: :not_found
	end

	def create
		if params[:user_friendship] && params[:user_friendship].has_key?(:friend_id)
			@friend = User.where(profile_name: params[:user_friendship][:friend_id]).first # I don't get this line
			@user_friendship = current_user.user_friendships.new(friend: @friend)
			@user_friendship.save
			flash[:success] = "You are now friends with #{@friend.full_name}"
			redirect_to profiles_path(@friend)
		else
			flash[:error] = "Nah man you ain't friends, you're changes"
			redirect_to root_path
		end
	end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_friendship
      @user_friendship = current_user.user_friendships.new(friend: @friend)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_friendship_params
      params.require(:user_friendship).permit(:friend_id, :profile_name, :user_id)
    end
end
