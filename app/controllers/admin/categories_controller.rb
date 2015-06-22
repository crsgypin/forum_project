class Admin::CategoriesController < ApplicationController
	before_action :authenticate_admin

	def create
		@category = Category.new(category_params)
		@category.creator_id = current_user.id
		if @category.save
			flash[:notice] = "Category #{@category.name} has been created successfully"
			redirect_to admin_articles_path
		else
			render :template => 'admin/articles/index'
		end
	end


	def update
		@category = Category.find(params[:category][:id])
		if @category.update(category_params)
			flash[:notice] = "Category #{@category.name} has been updated successfully"
			redirect_to admin_articles_path			
		else
			render :template => 'admin/articles/index'
		end

	end

	def destroy 
		@category = Category.find(params[:category_id])
		if @category.destroy
			flash[:notice] = "Category #{@category.name} has been deleted successfully"			
			redirect_to admin_articles_path			
		else
			render :template => 'admin/articles/index'
		end
	end

	private
	def category_params
		params.require(:category).permit(:name)

	end


end
