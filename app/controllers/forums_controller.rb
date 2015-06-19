class ForumsController < ApplicationController
	before_action :authenticate_user!
	before_action :debug

	def index

		@per = 10
		@page = params[:page].to_i
		@active_articles = @active_category.articles.page(@page).per(@per)


	end


	def article

		@article = Article.find(params[:id])
	end

private
	def debug
		Rails.logger.debug("=------------=")		
		# Rails.logger.debug(URI(request.referer).path)
	end

end
