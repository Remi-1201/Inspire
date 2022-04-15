class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
  end

  def new
  end

  def show    
  end

  def english
    @blogs = Blog.all.order(created_at: :desc).kaminari(params[:page]).per(10)
    @favorite = current_user.favorites.find_by(blog_id: params[:blog_id], user_id: current_user.id)
  end

  def japanese
    @blogs = Blog.all.order(created_at: :desc).kaminari(params[:page]).per(10)
    @favorite = current_user.favorites.find_by(blog_id: params[:blog_id], user_id: current_user.id)
  end

  def create
  end

  private  
  def category_params
    params.require(:category).permit(:name,:blog_id, :user_id)
  end
  def set_category
    @category = Category.find(params[:id])
    @blog = Blog.find(params[:blog_id])
    @user = User.find_by(id: session[:user_id]) 
  end
end

 

