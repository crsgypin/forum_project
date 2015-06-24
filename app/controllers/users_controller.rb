class UsersController < ApplicationController
	before_action :set_user 
	def show
		redirect_to profile_user_path(@user)
	end


	def show_profile
		@user_profile = @user.user_profile
		render :template =>"users/profile_show"		
	end

	def edit_profile

	end

	def update_profile

	end

	def posted_articles
		@post_articles = @user.post_articles.where("status = 'published'").order(:updated_at => :desc)
		render :template =>"users/articles"
	end

	def posted_comments
		@comments = @user.comments.order(:updated_at => :desc)
		render :template =>"users/comments"
	end

	def draft
		@draft_articles = @user.post_articles.where("status = 'draft'").order(:updated_at => :desc)
	end

	def favorite
		@favorite_articles = @user.favorite_articles.order("favorites.updated_at desc")

	end

	def favorite_delete
		@favorite_article = Favorite.find_by(:user_id=>params[:id],:article_id=>params[:article_id])
		@favorite_article.destroy
		flash[:notice]="You've removed the article from your favorite"
		redirect_to :favorite
	end

private

	def set_user
		@user = User.find(params[:id])
	end
end
