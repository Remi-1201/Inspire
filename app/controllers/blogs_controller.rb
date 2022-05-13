class BlogsController < ApplicationController
  protect_from_forgery with: :exception, only: :create
  before_action :set_blog, only: %i[ show edit update destroy ]
  
  def index
    @users = User.all
    @blogs = Blog.all.includes(:user).order(created_at: :desc).kaminari(params[:page]).per(10)
    @favorite = current_user.favorites.find_by(blog_id: params[:blog_id]) if current_user.present?
    @blogs = @blogs.joins(:categories).where(categories: { id: params[:category_id] }) if params[:category_id].present?
    @blogs = @blogs.joins(:tags).where(tags: { id: params[:tag_id] }) if params[:tag_id].present?    
    
    @tags = Tag.where(user_id: nil).or(Tag.where(user_id: current_user.id)) if current_user.present? 
    @tag_list= Tag.all  
  end
  
  def new
    @blog = Blog.new
    @blog.categorizings.build
    @tag = @blog.taggings.build
    @tags = Tag.where(user_id: nil).or(Tag.where(user_id: current_user.id))
  end

  def create
    @categories = Category.all.map{ |c| [c.name, c.id] }
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id  
    tag_list = params[:blog][:name].split(',') 
    respond_to do |format|
      if @blog.save
        @blog.save_tag(tag_list)
        format.html { redirect_to blogs_path, notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @users = User.all
    @blogs = Blog.all.includes(:user)
    @comments = @blog.comments
    @comment = @blog.comments.build    
    @favorite = current_user.favorites.find_by(blog_id: @blog.id) if params[:tag_id].present?  
    @tags = Tag.where(user_id: nil).or(Tag.where(user_id: current_user.id)) if current_user.present?
    @taggings = @blog.tags
  end

  def edit
    @tags = Tag.where(user_id: nil).or(Tag.where(user_id: current_user.id))
    @tag_list=@blog.tags.pluck(:name).join(',')
  end

  def update
    @categories = Category.all.map{ |c| [c.name, c.id] }
    tag_list=params[:blog][:name].split(',')
    respond_to do |format|
      if @blog.user_id = current_user.id 
        @blog.update(blog_params)

        @old_relations=Tagging.where(blog_id: @blog.id)
        @old_relations.each do |relation|
          relation.delete
        end            

        @blog.save_tag(tag_list)

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
        format.html { redirect_back fallback_location: root_path, notice: "Blog was successfully destroyed." }
        format.json { head :no_content }    
      else
        redirect_back fallback_location: root_path, notice: "Permission denied!"
      end
    end
  end

  def search_tag
    @tag_list=Tag.all
    @tag=Tag.find(params[:tag_id])
    @blogs = Blog.joins(:tags).where(tags: { name: @tag.name }).order('created_at desc').kaminari(params[:page]).per(10)
  end

  private
  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:detail, :title,  :image_cache, :image,{ category_ids: []}, tag_ids: [])
  end

end