class Admin::ArticlesController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_admin


	def index
		@articles = Article.all
		@users = User.all.page(params[:page]).per(20)
		unless params[:category_id]
			@category = Category.new
		else
			@category = Category.find(params[:category_id])
		end
	end


end
	


