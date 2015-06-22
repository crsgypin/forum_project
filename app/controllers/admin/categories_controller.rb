class Admin::CategoriesController < ApplicationController
	before_action :authenticate_admin

	def create
		@category = Category.new(category_params)
		@category.create_id = current_user.id
		if @category.save
			flash[:notice] = "Category #{@category.name} has been created successfully"
			redirect_to admin_articles_path
		else
			render :template => 'admin/articles'
		end
	end

	def destroy 
		@category = Category.find(params[:category_id])


	end


	private
	def category_params
		params.require(:category).permit(:name)

	end


end
