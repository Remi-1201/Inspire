class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]

  load_and_authorize_resource
  before_action :authenticate_user! 

  def index
    @blogs = Blog.all.includes(:user).order(created_at: :desc).kaminari(params[:page]).per(10)
    @favorite = current_user.favorites.find_by(blog_id: params[:blog_id])
  end

  def show
    @blogs = Blog.all.includes(:user)
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
        format.html { redirect_back fallback_location: root_path, notice: "Blog was successfully updated." }
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
        format.html { redirect_back fallback_location: root_path, notice: "Blog was successfully destroyed." }
        format.json { head :no_content }    
      else
        redirect_back fallback_location: root_path, notice: "Permission denied!"
      end
    end
  end

  def search    
    @blogs = @blogs.page(params[:page])
    @blogs =
    if params[:search_title].blank? && params[:search_detail].blank?
      Blog.all.order(created_at: :desc).kaminari(params[:page])
    elsif params[:search_title].present? && params[:search_detail].present?
      Blog.where('title LIKE ?', "%#{params[:search_title]}%").where(detail: params[:search_detail]).order(created_at: :desc).kaminari(params[:page])
    elsif params[:search_title].present? && params[:search_detail].blank?
      Blog.where('title LIKE ?', "%#{params[:search_title]}%").order(created_at: :desc).kaminari(params[:page])
    elsif params[:search_title].blank? && params[:search_detail].present?
      Blog.where('detail LIKE ?', "%#{params[:search_detail]}%").order(created_at: :desc).kaminari(params[:page])
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
end

