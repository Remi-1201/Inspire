class FavoritesController < ApplicationController
  before_action :set_blog, only: %i[create destroy]

  def index
    if current_user.present?
      @favorites = current_user.favorites.order(created_at: :desc).kaminari(params[:page]).per(10)    
      @blogs = Blog.all.includes(:user).order(created_at: :desc).kaminari(params[:page]).per(10)    
      @favorite = current_user.favorites.find_by(blog_id: params[:blog_id])
    else
      redirect_back fallback_location: root_path, notice: "Please sign up or login first!"
    end
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog)
    @blogs = Blog.all.includes(:user)
  end

  def list
  end

  def create
    if current_user.present?
      @blog = Blog.find(params[:blog_id])
      favorite = current_user.favorites.build(blog_id: params[:blog_id])
      favorite.save
    else
      redirect_back fallback_location: root_path, notice: "Please sign up or login to like!"
    end
  end 

  def destroy
    @blog = Blog.find(params[:blog_id])
    favorite = Favorite.find_by(blog_id: params[:blog_id], user_id: current_user.id)
    favorite.destroy
  end

  private
  def set_blog
    @blog = Blog.find(params[:blog_id])
    @users = User.all
  end
end