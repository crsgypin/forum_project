class AboutsController < ApplicationController

	def index
		@total_articles = Article.all.count
		@total_users = User.all.count
		@total_comments = Comment.all.count
	end

end
