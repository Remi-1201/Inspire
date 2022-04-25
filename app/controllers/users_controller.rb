class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  
  def mypage
    redirect_to user_path(current_user.id)
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def show
    user = User.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: params[:blog_id], user_id: user.id) 
    @blogs = Blog.where(user_id: nil).or(Blog.where(user_id: user.id)).kaminari(params[:page]) 
  end

  def update
  if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end  

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :name, :password_digest, :password, :password_confirmation, :email, :avatar, :sign_in, keys: [:attribute])
  end  
end