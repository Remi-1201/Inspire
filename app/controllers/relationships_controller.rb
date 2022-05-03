class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  respond_to? :js # 存在するアクションのrespondを全てjsで返す 

  def create 
    if signed_in?
      @user = User.find(params[:relationship][:followed_id])
      current_user.follow!(@user) 
    end  
  end

  def show    
    @user = User.find(params[:id]) 
    @followings = @user.following
    @followers = @user.followers
  end

  def followings
    @user = User.find(params[:user_id])  
    @followings = @user.following
  end

  def followers
    @user = User.find(params[:user_id])  
    @followers = @user.followers
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
  end
end
