class ForumsController < ApplicationController
	before_action :authenticate_user!

	def index
		active_id = (params[:category_id])? params[:category_id] : 1
		@per = 10
		@page = params[:page].to_i
		@active_category = Category.find(active_id)
		@active_articles = @active_category.articles.page(@page).per(@per)


	end


	def article

		@article = Article.find(params[:id])
		

	end



end
