class ArticlesController < ApplicationController
	before_action :authenticate_user!

	def index

		@per = 10
		@page = params[:page].to_i
		@active_articles = @active_category.articles.order(:updated_at => :desc).page(@page).per(@per)

	end

	def new
		@new_article = Article.new

	end

	def create
		@new_article = Article.new(post_article_params)
		@new_article[:author_id] = current_user.id

		if @new_article.save
			flash[:notice] = "You had posted one article"
			redirect_to articles_path
		else
			render :new
		end
	end

	def edit
		@edit_article = Article.find(params[:id])
	end

	def update
		@edit_article = Article.find(params[:id])
		if @edit_article.update(post_article_params)
			flash[:notice] = "You had updated you article"
			redirect_to article_path(@edit_article)
		else
			render :edit
		end
	end

	def destroy
		@delete_article = Article.find(params[:id])
		if @delete_article.destroy
			flash[:notice] = "You had deleted your article"
			redirect_to articles_path
		end
	end

	def show
		@article_id = params[:id]
		@article = Article.find(@article_id)

		unless params[:comment_id]
			@comment = Comment.new
			unless ArticleView.find_by(article_id: @article_id, user_id: current_user.id)
				ArticleView.create(article_id: @article_id,user_id: current_user.id)
			end
		else
			@comment = Comment.find(params[:comment_id]) 
		end
	end

	def about
		@total_articles = Article.all.count
		@total_users = User.all.count
		@total_comments = Comment.all.count
	end

private
	def post_article_params	
		params.require(:article).permit(:title,:content,:category_ids => [])

	end

end
