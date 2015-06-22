class CommentsController < ApplicationController

	def create
		if current_user
			@comment = Comment.new(params_comment)
			@comment[:user_id]=current_user.id
			@comment[:article_id]=params[:id]
			if @comment.save
				flash[:notice]="your comment has been successful posted"
				redirect_to article_path(params[:id])
			else
				@article = Article.find(params[:id])
				render :template => 'articles/show'

			end
		else
			redirect_to new_session(:user)
		end
	end

	def update
		@comment = Comment.find(params[:comment_id])
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
		@comment = Comment.find(params[:comment_id])
		@comment.destroy
		flash[:notice] = "You comment has been successfully deleted"
		redirect_to article_path(params[:id])
	end

private
	def params_comment
		params.require(:comment).permit(:content)
	end
end
