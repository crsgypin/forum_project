class ArticlesController < ApplicationController

	before_action :authenticate_user!, :except=>[:index, :show, :about]

	def index
		set_article_list
		@articles = @articles.page(params[:page]).per(10)
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(post_article_params)
		
		@article.user = current_user

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
		@article = current_user.articles.find(params[:id])
	end

	def update
		@article = current_user.articles.find(params[:id])

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
		@delete_article = current_user.articles.find(params[:id])
		if @delete_article.destroy
			flash[:notice] = "You had deleted your article"
			redirect_to articles_path
		end
	end

	def show
		@article = Article.find( params[:id] )
		@poster = @article.user

		@comments = @article.comments

		@comment = Comment.new		

		if current_user
			@favorite = current_user.favorites.find_by_article_id(@article.id)

			@like = current_user.likes.find_by(:article_id=>@article.id)
			@like = current_user.likes.new unless @like
			# @like = current_user.likes.find_or_create_by(:article_id=>@article.id)

			@article.view!(current_user)
		end	

	end

	def add_favorite
		@favorite = current_user.favorites.build( :article_id=> params[:id] )

		if @favorite.save
			flash[:notice]= "You have saved the favorite to this article"
			redirect_to article_path(params[:id])
		else
			render :show
		end
	end

	def remove_favorite
		@favorite = current_user.favorites.find_by_article_id( params[:id] )

		if @favorite.destroy
			flash[:notice]= "You have removed the favrite to this article"
			#redirect_to article_path(params[:id])
			redirect_to :back
		else
			render :show
		end
	end

	def like
		@article = Article.find( params[:id] )		
		@like = current_user.likes.find_by_article_id(params[:id])
		unless @like
			@like = current_user.likes.create(:article_id=>params[:id])
		else
			@like.destroy
			@like = Like.new

		end

		respond_to do |format|
			format.js {
				render 'articles/like'
			}
		end

	end

	private

	def post_article_params	
		params.require(:article).permit(:title,:content,:category_ids => [])
	end

	def set_article_list
		@articles = @category? @category.articles : Article.all
		@articles = @articles.where( :status => 'published' )

		if params[:order] == 'comment'
      @articles = @articles.order('comments_count desc')
		elsif params[:order] == 'views'
      @articles = @articles.order('views_count desc')			
    elsif params[:order] == 'last_comment'
    	@articles = @articles.order('last_comment_at desc')
    else
    	@articles = @articles.order('updated_at desc')
		end
	end

end
