class Admin::ArticlesController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_admin


	def index
		@action_list = ["dashboard","category","user list"]
		@action_index = params[:action_id] ? params[:action_id].to_i : 0
		@articles = Article.all
		@users = User.all.page(params[:page]).per(20)
		unless params[:category_id]
			@category = Category.new
		else
			@category = Category.find(params[:category_id])
		end
	end


end
	


