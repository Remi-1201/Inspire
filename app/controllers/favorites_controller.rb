class FavoritesController < ApplicationController

  def index
    @favorites = current_user.favorites
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
    favorite = current_user.favorites.create(blog_id: params[:blog_id])
    if @blog.user.name.present?
      redirect_back fallback_location: root_path, notice: "You liked #{@blog.user.name}'s post."
    else
      redirect_back fallback_location: root_path, notice: "You liked guest's post."
    end
  end

  def destroy
    if current_user.favorites.find_by(blog_id: params[:blog_id], user_id: current_user.id).present?
      favorite = current_user.favorites.find_by(blog_id: params[:blog_id], user_id: current_user.id).destroy
      redirect_back fallback_location: root_path,  notice: "Post was disliked!"
    else
      redirect_back fallback_location: root_path, notice: "Permission denied!"
    end
  end
end