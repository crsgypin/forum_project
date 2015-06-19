class ApplicationController < ActionController::Base
	before_action :set_active_category


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


protected
	
	def set_active_category
		active_id = (params[:category_id])? params[:category_id] : 1
		@active_category = Category.find(active_id)
	end


end
