class BlogsController < ApplicationController
  protect_from_forgery with: :exception, only: :create
  before_action :set_blog, only: %i[ show edit update destroy ]

  load_and_authorize_resource
  before_action :authenticate_user! 

  def index
    @users = User.all
    @blogs = Blog.all.includes(:user).order(created_at: :desc).kaminari(params[:page]).per(10)
    @favorite = current_user.favorites.find_by(blog_id: params[:blog_id]) 
    @blogs = @blogs.joins(:categories).where(categories: { id: params[:category_id] }) if params[:category_id].present?
    @blogs = @blogs.joins(:tags).where(tags: { id: params[:tag_id] }) if params[:tag_id].present?    
    
    @tags = Tag.where(user_id: nil).or(Tag.where(user_id: current_user.id))  
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
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)    
    @tags = Tag.where(user_id: nil).or(Tag.where(user_id: current_user.id))
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

  def sort
    @blogs = searched
    @search_detail = session[:search]['detail']  if session[:search].present?
    @tags = Tag.where(user_id: nil).or(Tag.where(user_id: current_user.id))
    @blogs =
      if params[:sort] == 'created_at'
        @blogs.sorted
      elsif params[:sort] == 'category'
        @blogs.category_sorted
      elsif params[:sort] == 'tag'
        @blogs.tag_sort          
      end
    session[:search] = nil
    render :index
  end

  def search
    session[:search] = {'detail' => params[:search_detail], 'category' => params[:search_category], 'tag' => params[:search_tag]}
    @tags = Tag.where(user_id: nil).or(Tag.where(user_id: current_user.id))
    @blogs = searched
    @blogs = @blogs.sorted
    @search_tag = session[:search]['tag']
    @search_detail = session[:search]['detail']
    @tag_list=Tag.all
    render :index
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

  def searched 
    @blogs = @blogs.page(params[:page])
    if session[:search].present?
      # all blank
      if session[:search]['detail'].blank? && session[:search]['category'].blank? && session[:search]['tag'].blank?
        Blog.all.includes(:user).order(created_at: :desc).kaminari(params[:page]).per(10)

        # detail = present
        elsif session[:search]['detail'].present?
          # category & tag = present 
          if session[:search]['category'].present? && session[:search]['tag'].present?
            Blog.search_sort(session[:search]['detail']).category_sort(session[:search]['category']).tag_sort(session[:search]['tag']).kaminari(params[:page])          
          # category  = present
          elsif session[:search]['category'].present?
            Blog.search_sort(session[:search]['detail']).category_sort(session[:search]['category']).kaminari(params[:page])          
          # tag  = present
          elsif session[:search]['tag'].present?
            Blog.search_sort(session[:search]['detail']).tag_sort(session[:search]['tag']).kaminari(params[:page])           
        # else only detail  = present 
        else
          Blog.search_sort(session[:search]['detail']).kaminari(params[:page])
        end

        # category = present
        elsif session[:search]['category'].present?
          # tag = present 
          if session[:search]['tag'].present?
            Blog.category_sort(session[:search]['category']).tag_sort(session[:search]['tag']).kaminari(params[:page]) 
            # tag = blank 
          elsif session[:search]['tag'].blank?
            Blog.category_sort(session[:search]['category']).kaminari(params[:page])
        # else only category = present 
        else
          Blog.category_sort(session[:search]['category']).kaminari(params[:page])
        end

        # tag = present
        elsif session[:search]['tag'].present?
          # category = present 
          if session[:search]['category'].present?
            Blog.category_sort(session[:search]['category']).tag_sort(session[:search]['tag']).kaminari(params[:page])          
          # category = blank
          elsif session[:search]['category'].blank?
            Blog.tag_sort(session[:search]['tag']).kaminari(params[:page]) 
        # else only tag = present 
        else
          Blog.tag_sort(session[:search]['tag']).kaminari(params[:page]) 
        end
      
      else
        Blog.all.includes(:user).order(created_at: :desc).kaminari(params[:page]).per(10)
      end
    end
  end
end