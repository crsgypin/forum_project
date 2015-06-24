class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


protected
	
  def configure_permitted_parameters

    # devise_parameter_sanitizer.for(:sign_up){ |u| u.permit(:usernaem, 
    	# :category_id, :user_profile_attributes => [:id, :first_name, :last_name, :english_name, :brithdate, :intro]) }

    # devise_parameter_sanitizer.for(:account_update){ |u| u.permit(:usernaem, 
    	# :category_id, :user_profile_attributes => [:id, :first_name, :last_name, :english_name, :brithdate, :intro]) }

    devise_parameter_sanitizer.for(:sign_up){ |u| u.permit(:email, :username, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update){ |u| u.permit(:email, :username, :password, :password_confirmation) }

  end

  def authenticate_admin 
    unless current_user.admin? 
      raise ActiveRecord::RecordNotFound
    end
  end
end
