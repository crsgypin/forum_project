class Admin::ArticlesController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_admin


	def index
		@articles = Article.all

	end


end
	


