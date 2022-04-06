class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]
  # before_action :set_user

  load_and_authorize_resource
  before_action :authenticate_user! 

  def index
    @blogs = Blog.all
    @blogs = @blogs.joins(:categories).where(categories: { id: params[:category_id] }) if params[:category_id].present?

    # if !@user.id.nil?
    #   @blogs = Blog.favorited_pages(current_user).blog(params[:blog])
    #   @favorites = Favorite.find_by(user_id: current_user.id)
    # else
    #   @blogs = Blog.all.order('updated_at DESC').blog(params[:blog])
    # end
  end

  def show
    @comments = @blog.comments
    @comment = @blog.comments.build    
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def new
    @blog = Blog.new
    @blog.categorizings.build
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id  
    respond_to do |format|
      if @blog.save
        format.html { redirect_to blogs_path, notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.user_id = current_user.id 
        @blog.update(blog_params)
        format.html { redirect_to blogs_path, notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
      respond_to do |format|
      if @blog.user_id = current_user.id
        @blog.destroy
        format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
        format.json { head :no_content }    
      else
      redirect_to blogs_path, notice: "Permission denied!"
      end
    end
  end

  def search
    @blogs =
    if params[:search_title].blank? && params[:search_detail].blank?
      Blog.all.order(created_at: :desc)
    elsif params[:search_title].present? && params[:search_detail].present?
      Blog.where('title LIKE ?', "%#{params[:search_title]}%").where(detail: params[:search_detail]).order(created_at: :desc)
    elsif params[:search_title].present? && params[:search_detail].blank?
      Blog.where('title LIKE ?', "%#{params[:search_title]}%").order(created_at: :desc)
    elsif params[:search_title].blank? && params[:search_detail].present?
      Blog.where('detail LIKE ?', "%#{params[:search_detail]}%").order(created_at: :desc)
    end
    render :index
  end

  private
  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:detail, :title,  :image_cache, :image,{ category_ids: []} )
  end

  # def set_user
  #   # current_userがnilだったら空のUserインスタンスを設定
  #   @user = current_user || User.new
  # end
end

