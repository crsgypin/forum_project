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

private
	def params_comment
		params.require(:comment).permit(:content)
	end
end
