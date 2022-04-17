class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_back fallback_location: root_path, notice: "Permission denied!"
  end

  def configure_permitted_parameters
    added_attrs = [ :email, :name, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

  def after_sign_in_path_for(resource)
    flash[:notice] = "Hello #{@user.name}! You have successfully logged in."
    blogs_path    
  end

  private
  def set_current_user 
    @current_user = User.find_by(id: session[:user_id])
  end
end
