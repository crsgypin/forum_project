class ForumsController < ApplicationController
	before_action :authenticate_user!

	def index
		active_id = (params[:category_id])? params[:category_id] : 1
		@active_category = Category.find(active_id)
		@active_articles = @active_category.articles.limit(10)


	end


	def article

		@article = Article.find(params[:id])
		

	end



end
