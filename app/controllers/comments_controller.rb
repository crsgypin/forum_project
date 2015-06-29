class CommentsController < ApplicationController
	before_action :authenticate_user!, :set_article

	def create		
		Rails.logger.debug("======== abccc")
		Rails.logger.debug(@article.inspect)		
		@comment = Comment.new(params_comment)
		@comment.user =current_user
		@comment.article = @article
		if @comment.save		

			# @comment.article.touch(:last_comment_at)
			
			@comment = Comment.new					
			@notice = 'your comment has been successful posted'

		else
			@alert = @comment.errors.full_messages.join(' ').html_safe
		end

	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def update
		@comment = Comment.find(params[:id])
		@comment.update(params_comment)
		if @comment.save
			@notice = "your comment has been successfully updated"
			@comment = Comment.new

		else
			@alert = @comment.errors.full_messages.join(' ').html_safe
		end
	end


	def destroy
		@comment = @article.comments.find(params[:id])
		@comment.destroy
		@notice = "You comment has been successfully deleted"
	end

private
	def params_comment
		params.require(:comment).permit(:content)
	end

	def set_article
		@article = Article.find(params[:article_id])
	end

end
