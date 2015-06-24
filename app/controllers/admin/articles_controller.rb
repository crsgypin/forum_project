class Admin::ArticlesController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_admin


	def index
		@page = params[:page].to_i ||= 0
		@per = 20
		@articles = Article.all.page(@page).per(@per)

	end


end
	


