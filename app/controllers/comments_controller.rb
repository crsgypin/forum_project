class CommentsController < ApplicationController
	before_action :authenticate_user!, :find_article_and_comments

	def create		
		if current_user
			@comment = Comment.new(params_comment)
			@comment.user =current_user
			@comment.article = @article

			if @comment.save
				@comment = Comment.new
				@notice = 'your comment has been successful posted'
			else
				@notice = @comment.errors.full_messages.join(' ').html_safe
			end

			refresh
		else
			redirect_to new_session(:user)
		end
	end

	def edit

		@comment = Comment.find(params[:id])
		refresh
	end

	def update
		@comment = Comment.find(params[:id])
		@comment.update(params_comment)
		if @comment.save
			@notice = "your comment has been successfully updated"
			@comment = Comment.new

		else
			@notice = @comment.errors.full_messages.join(' ').html_safe
		end
		refresh
	end


	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		@comment = Comment.new
		@notice = "You comment has been successfully deleted"
		refresh
	end

private
	def params_comment
		params.require(:comment).permit(:content)
	end

	def find_article_and_comments
		@article = Article.find(params[:article_id])
		@comments = @article.comments.all
	end

	def refresh
		respond_to do |format|
			format.js {
				render 'comments/refresh'
			}
		end
	end

end
