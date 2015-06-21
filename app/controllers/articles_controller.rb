class ArticlesController < ApplicationController
	before_action :authenticate_user!

	def index

		@per = 10
		@page = params[:page].to_i
		@articles = @active_category? @active_category.articles : Article.all
		@articles = @articles.where("status = 'published'")

		if params[:order] == 'comment'
      @articles = @articles.select('articles.*, count(comments.id) as comment_count')
      @articles = @articles.joins('left join comments on articles.id=comments.article_id')
      @articles = @articles.group('articles.id')
      @articles = @articles.order('comment_count desc')
			# select articles.*, count(comments.id) as comment_count, comments.id from articles left join comments on articles.id = comments.article_id group by articles.id order by comment_count desc

		elsif params[:order] == 'views'
      @articles = @articles.select('articles.*, count(article_views.id) as view_count')
      @articles = @articles.joins('left join article_views on articles.id=article_views.article_id')
      @articles = @articles.group('articles.id')
      @articles = @articles.order('view_count desc')			

    else
    	@articles = @articles.order('updated_at desc')

		end

		@articles = @articles.page(@page).per(@per)

	end

	def new
		@new_article = Article.new

	end

	def create
		@new_article = Article.new(post_article_params)
		@new_article[:author_id] = current_user.id
		if params[:commit] == 'Publish'
			@new_article.status = 'published'
			if @new_article.save
				flash[:notice] = "You had posted one article"
				redirect_to articles_path
			else
				render :new
			end

		elsif params[:commit] == 'Save'
			@new_article.status = 'draft'
			if @new_article.save
				flash[:notice] = "You had saved one article, not published yet"
			end
			render :new
		end

	end

	def edit
		@edit_article = Article.find(params[:id])
	end

	def update
		@edit_article = Article.find(params[:id])
		if params[:commit] == 'Publish'
			@new_article.status = "published"
			if @edit_article.update(post_article_params)
				flash[:notice] = "You had updated your article"
				redirect_to article_path(@edit_article)
			else
				render :edit
			end
		elsif params[:commit] == 'Save'
			if @edit_article.update(post_article_params)
				flash[:notice] = "You had saved your article, not published yet"
				redirect_to user_path(current_user)
			else
				render :edit
			end
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

		if current_user
			@favorite = Favorite.find_by(:article_id=>@article_id,:user_id=>current_user.id)
		end	

		unless params[:comment_id]
			@comment = Comment.new
			unless ArticleView.find_by(article_id: @article_id, user_id: current_user.id)
				ArticleView.create(article_id: @article_id,user_id: current_user.id)
			end
		else
			@comment = Comment.find(params[:comment_id]) 
		end
	end

	def favorite_create
		@favorite = Favorite.new(:user_id=>params[:user_id],:article_id=>params[:id])
		if @favorite.save
			flash[:notice]= "You have saved the favrite to this article"
			redirect_to article_path(params[:id])
		else
			render :show
		end
	end

	def favorite_delete
		@favorite = Favorite.find_by(:user_id=>params[:user_id],:article_id=>params[:id])

		if @favorite.destroy
			flash[:notice]= "You have removed the favrite to this article"
			redirect_to article_path(params[:id])
		else
			render :show
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
