class ProfilesController < ApplicationController
  
  def show
  	@user = User.find_by_profile_name(params[:id]) #trying to find user by id
  	if @user
  			@statuses = @user.statuses.all
  			render action: :show
  	else
				render file: 'public/404', status: 404, formats: [:html] #when a web browser requests something and its not found
		end
  end

end
