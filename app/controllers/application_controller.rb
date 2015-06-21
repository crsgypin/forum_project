class ApplicationController < ActionController::Base
	before_action :set_active_category

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


protected
	
	def set_active_category
    @categories = Category.all
    if params[:category_id]

      @active_category_id = params[:category_id].to_i
      @active_category = Category.find(@active_category_id)
    else
      @active_category_id = 0
    end
	end

  def configure_permitted_parameters

    devise_parameter_sanitizer.for(:sign_up){ |u| u.permit(:usernaem, 
    	:category_id, :user_profile_attributes => [:id, :first_name, :last_name, :english_name, :brithdate, :intro]) }

    devise_parameter_sanitizer.for(:account_update){ |u| u.permit(:usernaem, 
    	:category_id, :user_profile_attributes => [:id, :first_name, :last_name, :english_name, :brithdate, :intro]) }


    # devise_parameter_sanitizer.for(:account_update){ |u| u.permit(:username, :first_name, :user_profile_last_name, :user_profile_intro) }

  end


end
