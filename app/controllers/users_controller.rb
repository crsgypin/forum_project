class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:show, :show_profile, :posted_articles, :posted_comments]
	before_action :set_user 

	def show
		redirect_to user_profile_path(@user)
	end

	def articles
		@post_articles = @user.post_articles.where("status = 'published'").order(:updated_at => :desc)
		render :template =>"users/articles"
	end

	def comments
		@comments = @user.comments.order(:updated_at => :desc)
		render :template =>"users/comments"
	end

	def like_articles
		@like_articles = @user.like_articles
	end

	def draft
		@draft_articles = @user.post_articles.where("status = 'draft'").order(:updated_at => :desc)
	end

	def favorite
		@favorite_articles = @user.favorite_articles.order("favorites.updated_at desc")

	end

	def friends
		@friendships = @user.friendships
		@completed_friendships = @friendships.map{|fs| fs if fs.status=="completed"}.compact
		@invited_friendships = @friendships.map{|fs| fs if fs.status=="invited"}.compact
		@other_friendships = @friendships - @invited_friendships - @completed_friendships
	end

private
	
	def set_user
		@user = User.find_by_friendly_id(params[:id])
	end
end
