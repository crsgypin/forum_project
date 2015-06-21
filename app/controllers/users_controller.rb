class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])

		@favorite_articles = @user.favorite_articles.order("favorites.updated_at desc")
	end

	def favorite_delete
		@favorite_article = Favorite.find_by(:user_id=>params[:id],:article_id=>params[:article_id])
		@favorite_article.destroy
		flash[:notice]="You've remove the article from your favorite"
		redirect_to user_path(params[:id])
	end

end
