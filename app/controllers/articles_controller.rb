class ArticlesController < ApplicationController
	before_action :authenticate_user!, :except=>[:index, :show, :about]

	def index
		@per = 10
		@page = params[:page].to_i
		set_article_list
		@articles = @articles.page(@page).per(@per)

	end

	def new
		@article = Article.new

	end

	def create
		@article = Article.new(post_article_params)
		@article[:author_id] = current_user.id
		if params[:commit] == 'Publish'
			@article.status = 'published'
			if @article.save
				flash[:notice] = "You had posted one article"
				redirect_to articles_path
			else
				@article.status = "draft"
				render :new
			end

		elsif params[:commit] == 'Save'
			@article.status = 'draft'
			if @article.save
				flash[:notice] = "You had saved one article, not published yet"
				redirect_to user_path(current_user)
			else
				render :new				
			end

		end

	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])

		if params[:commit] == "Update"
			if @article.update(post_article_params)
				flash[:notice] = "You had updated your article"
				redirect_to article_path(@article)
			else
				render :edit
			end
		elsif params[:commit] == 'Publish'
			@article.status = "published"
			if @article.update(post_article_params)

				flash[:notice] = "You had posted your article"
				redirect_to article_path(@article)
			else
				@article.status = "draft"
				render :edit
			end

		elsif params[:commit] == 'Save'
			if @article.update(post_article_params)
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
		@poster = @article.user
		@comments = @article.comments

		if current_user
			@favorite = Favorite.find_by(:article_id=>@article_id,:user_id=>current_user.id)

			unless params[:comment_id]
				@comment = Comment.new
				unless ArticleView.find_by(article_id: @article_id, user_id: current_user.id)
					ArticleView.create(article_id: @article_id,user_id: current_user.id)
				end
			else
				@comment = Comment.find(params[:comment_id]) 
			end
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

	def check_article_category_ship
		params[:category_ids].present?
	end	

	def set_article_list
		@articles = @category? @category.articles : Article.all
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
	end

end
