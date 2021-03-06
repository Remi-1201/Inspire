class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user
  before_action :set_q, only: [:index, :search] 
  before_action :search

  def search
    @search_blog = Blog.ransack(params[:blog_q])  
    @search_blogs = @search_blog.result.joins(:user).includes(:user).includes(:tags).kaminari(params[:page]).per(10) 
    @search_user = User.ransack(params[:user_q])  
    @search_users = @search_user.result(distinct: true) 
  end

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

  def set_q
    @blog_q = Blog.ransack(params[:blog_q], search_key: :blog_q)  
    @user_q = User.ransack(params[:user_q], search_key: :user_q)  
  end
end
