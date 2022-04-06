class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # alias_method :devise_current_user, :current_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to blogs_path, notice: "Permission denied!"
  end

  def configure_permitted_parameters
    added_attrs = [ :email, :name, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
  
  # def current_user
  #   if devise_current_user.nil?
  #     User.new
  #   else
  #     User.find_by_id(devise_current_user.id)
  #   end
  # end

  private
end
