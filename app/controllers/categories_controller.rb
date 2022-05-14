class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ] 

  def index 
  end

  def new
  end
 
  def show    
  end

  def english 
    @blogs = Blog.joins(:categories).where(categories: {name: "English"}).kaminari(params[:page]).per(10)
    @favorite = current_user.favorites.find_by(blog_id: params[:blog_id], user_id: current_user.id) if current_user.present?
  end

  def japanese 
    @blogs = Blog.joins(:categories).where(categories: {name: "Japanese"}).kaminari(params[:page]).per(10)
    @favorite = current_user.favorites.find_by(blog_id: params[:blog_id], user_id: current_user.id) if current_user.present?
  end 

  def create
  end

  private  
  def category_params
    params.require(:category).permit(:name,:blog_id, :user_id,:blog)
  end

  def set_category
    @category = Category.find(params[:id])
    @blog = Blog.find(params[:blog_id])
    @user = User.find_by(id: session[:user_id]) 
    @users = User.all
  end
 
end

