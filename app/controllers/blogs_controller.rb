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
    @blogs = Blog.all.order(created_at: :desc)
  end

  def show
    @comments = @blog.comments
    @comment = @blog.comments.build
  end

  def new
    @blog = Blog.new
  end

  def edit
  end

  def create
    @blog = Blog.new(blog_params)
    # @blog.user_id = current_user.id
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

  private
    def set_blog
      @blog = Blog.find(params[:id])
    end

    def blog_params
      params.require(:blog).permit(:detail)
    end
end
