class ForumsController < ApplicationController
	before_action :authenticate_user!

	def index

		@per = 10
		@page = params[:page].to_i
		@active_articles = @active_category.articles.page(@page).per(@per)


	end


	def article

		@article = Article.find(params[:id])
		

	end



end
