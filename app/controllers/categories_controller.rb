class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show
    @blogs = Blog.where(category_id: current_category)
  end

  def english
    @blogs = Blog.all
  end

  def japanese
    @blogs = Blog.all
  end

  def create
    @blog = current_blog
    @categories = @blog.categoies.build(category_params)
    respond_to do |format|
      if @blog.save
        format.js { render :index }
      else
        format.html { redirect_to blogs_path(@blog) }
      end
    end
  end

  private  
  def category_params
    params.require(:category).permit(
      :name,       
      blog_ids: []
    )
  end
  def set_category
    @category = Category.find(params[:id])
    @blog = Blog.find(params[:blog_id])
  end
end

 

