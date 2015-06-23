class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@post_articles = @user.post_articles.where("status = 'published'").order(:updated_at => :desc)
		@favorite_articles = @user.favorite_articles.order("favorites.updated_at desc")
		@comments = @user.comments.order(:updated_at => :desc)
		@draft_articles = @user.post_articles.where("status = 'draft'").order(:updated_at => :desc)

		@topic_list = ["Profile","Articles","Comments","Favroites","Draft"]
		if params[:topic_id]
			@topic_index = params[:topic_id].to_i
		else
			@topic_index =0
		end

	end

	def favorite_delete
		@favorite_article = Favorite.find_by(:user_id=>params[:id],:article_id=>params[:article_id])
		@favorite_article.destroy
		flash[:notice]="You've remove the article from your favorite"
		redirect_to user_path(params[:id])
	end

end
