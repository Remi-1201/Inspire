class FavoritesController < ApplicationController
  before_action :set_blog, only: %i[create destroy]

  def index
    @favorites = current_user.favorites.order(created_at: :desc).kaminari(params[:page]).per(10)    
    @blogs = Blog.all.includes(:user).order(created_at: :desc).kaminari(params[:page]).per(10)    
    @favorite = current_user.favorites.find_by(blog_id: params[:blog_id])
  end

  def show
    @comments = @blog.comments
    @comment = @blog.comments.build    
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
    @blogs = Blog.all.includes(:user)
  end

  def create
    @blog = Blog.find(params[:blog_id])
    favorite = current_user.favorites.build(blog_id: params[:blog_id])
    favorite.save 
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    favorite = Favorite.find_by(blog_id: params[:blog_id], user_id: current_user.id)
    favorite.destroy
  end

  private

  def set_blog
    @blog = Blog.find(params[:blog_id])

  end

  private
  def set_blog
    @blog = Blog.find(params[:blog_id])
  end
end