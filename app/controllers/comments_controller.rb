class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		if current_user
			@article = Article.find(params[:id])
			@comments = @article.comments.all

			@comment = Comment.new(params_comment)
			@comment.user =current_user
			@comment.article = @article

			if @comment.save
				@comment = Comment.new
				@notice = 'your comment has been successful posted'
			else
				@notice = @comment.errors.join(' ')
			end

			respond_to do |format|
				format.js {
					render 'comments/update'
				}
			end

		else
			redirect_to new_session(:user)
		end
	end

	def edit
		respond_to do |format|
			format.js{
				render 'comments/edit'
			}
		end
	end

	def update
		@comment = Comment.find(params[:comment_id])
		@comments = @article.comments.all
		@comment.update(params_comment)
		if @comment.save
			flash[:notice] = "your comment has been successfully updated"
			redirect_to article_path(params[:id])
		else
			@article = Article.find(params[:id])
			render :template => 'articles/show'
		end
	end


	def destroy
		@article = Article.find(params[:id])
		@comment = Comment.find(params[:comment_id])
		@comments = @article.comments.all
		@comment.destroy
		@comment = Comment.new
		@notice = "You comment has been successfully deleted"

		respond_to do |format|
			format.js {
				render 'comments/update'
			}
		end
			# format.js{ 
			# @cid = '#comment-' + params[:comment_id]
			# render 'comments/destroy'}



	end

private
	def params_comment
		params.require(:comment).permit(:content)
	end

end
