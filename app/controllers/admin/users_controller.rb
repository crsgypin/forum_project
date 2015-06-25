class Admin::UsersController < ApplicationController
	before_action :authenticate_user!, :except=>:show
	before_action :authenticate_admin

	def index
		@page = params[:page].to_i ||= 0
		@per = 20
		@users = User.all.page(@page).per(@per)

	end


	def show
		@user = User.find(params[:id])		

	end

	def edit
		@user = User.find(params[:id])
	end


	def update
		@user = User.find(params[:id])	
		if @user.update(user_params)
			flash[:notice]="You've updated #{@user.username}'s profile successfully"
			redirect_to admin_user_path(@user)
		else
			render :edit
		end	
	end

	def destroy
		@user = User.find(params[:id])
		if @user.destroy
			flash[:notice]="You've deleted this user's account successfully"
			redirect_to admin_users_path
		else
			render :index
		end
	end


private

	def user_params	
		params.require(:user).permit(:username, :role,
										:user_profile_attributes => [:first_name, :last_name, :english_name, :birthdate, :intro])

	end


end
