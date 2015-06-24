class Admin::UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_admin

	def index
			@page = params[:page] ||= 0
			@per = 20
			@users = User.all.page(@page).per(@per)

	end


	def show


	end

	def edit

	end


	def update

	end

	def destroy

	end



end
