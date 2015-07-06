class ProfilesController < ApplicationController

	def show
		@user = User.find( params[:user_id ] )
		@user_profile = @user.user_profile
		@friendship_status = Friendship.friend_status?(current_user,@user)

	end

	def edit
		@user = current_user
		@user_profile = @user.user_profile ||= @user.build_user_profile
	end

	def update
		@user = current_user

		if params[:destroy_image]
        @user.user_profile.image = nil
    end

		if @user.update(profile_params)
			flash[:notice] = "You've updated your profile data successfully"
			redirect_to user_profile_path(@user)
		else
			render "edit"
		end
	end

	protected

	def profile_params
		params.require(:user).permit(:username,
										:user_profile_attributes => [:id, :first_name, :last_name, :english_name, :birthdate, :intro, :image])
	end												


end
