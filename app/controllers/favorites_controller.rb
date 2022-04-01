class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(blog_id: params[:blog_id])
    redirect_to blogs_path, notice: "You liked #{favorite.blog.user.name}'s post."
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to blogs_path, notice: "You disliked #{favorite.blog.user.name}'s post."
  end
end
