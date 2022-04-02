class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]
  # before_action :authenticate_user

  # def authenticate_user
  #   @current_user = User.find_by(id: session[:user_id])
  #   if @current_user.nil?
  #     redirect_to new_user_session_path
  #   end
  # end

  def index
    @blogs = Blog.all
    @blogs = @blogs.joins(:categories).where(categories: { id: params[:category_id] }) if params[:category_id].present?
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

  def edit
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id  

    respond_to do |format|
      if @blog.save
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
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
      params.require(:blog).permit(:detail, :title, { category_ids: []} )
    end
end
