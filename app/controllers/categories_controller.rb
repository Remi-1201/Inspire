class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
    @categories = Category.all    
    @blogs = Blog.where(category_id: current_category).order(created_at: :desc).kaminari(params[:page])
    @favorite = current_user.favorites.find_by(blog_id: params[:blog_id])
    @user = User.find(params[:user_id])
  end

  def new
    @category = Category.new
  end

  def show
    @blogs = Blog.where(category_id: current_category).order(created_at: :desc).kaminari(params[:page])
    @user = User.find(params[:user_id])
  end

  def english
    @blogs = Blog.all.order(created_at: :desc).kaminari(params[:page])
    @user = User.find_by(id: session[:user_id]) 
  end

  def japanese
    @blogs = Blog.all.order(created_at: :desc).kaminari(params[:page])
    @user = User.find_by(id: session[:user_id]) 
  end

  def create
    @blog = current_blog
    @categories = @blog.categoies.build(category_params)
    respond_to do |format|
      if @blog.save
        format.js { render :index }
      else
        format.html { redirect_to blogs_path(@blog) }
      end
    end
  end

  private  
  def category_params
    params.require(:category).permit(
      :name,       
      blog_ids: []
    )
  end
  def set_category
    @category = Category.find(params[:id])
    @blog = Blog.find(params[:blog_id])
    @current_user = User.find_by(id: session[:user_id])
  end
end

 

