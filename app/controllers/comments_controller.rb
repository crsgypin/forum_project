class CommentsController < ApplicationController
	before_action :authenticate_user!, :find_article_and_comments

	def new
		@comment = Comment.new
	end

	def create		
		if current_user
			@comment = Comment.new(params_comment)
			@comment.user =current_user
			@comment.article = @article
			if @comment.save		
				# @comment.article.touch(:last_comment_at)
				
				@new_comment = Comment.new					
				@notice = 'your comment has been successful posted'
			else
				@alert = @comment.errors.full_messages.join(' ').html_safe
				render 'new'
			end

		else
			redirect_to new_session(:user)
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
			@new_comment = Comment.new

		else
			@alert = @comment.errors.full_messages.join(' ').html_safe
		end
	end


	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		@new_comment = Comment.new
		@notice = "You comment has been successfully deleted"
	end

private
	def params_comment
		params.require(:comment).permit(:content)
	end

	def find_article_and_comments
		@article = Article.find(params[:article_id])
		@comments = @article.comments
	end

	def refresh
		respond_to do |format|
			format.js {
				render 'comments/refresh'
			}
		end
	end

end
