class CommentsController < ApplicationController
  before_action :set_blog, only: [:create, :edit, :update]
  load_and_authorize_resource
  before_action :authenticate_user! 

  def index    
    @comments = @blog.comments.order(created_at: :desc).kaminari(params[:page]).per(5)
  end
  
  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to blog_path(@blog), notice: 'The commenting attempt failed.' }
      end
    end
  end

  def show
    @comment= current_user.comments.find_by(blog_id: @blog.id)
  end

  def edit
    @comment= current_user.comments.find_by(blog_id: @blog.id)
      respond_to do |format|
        if  @comment.user_id = current_user.id  
        flash.now[:notice] = 'Editing ...'
        format.js { render :edit }
      else
        redirect_back fallback_location: root_path, notice: "Permission denied!"
      end
    end
  end

  def update
    @comment= current_user.comments.find_by(blog_id: @blog.id)
    respond_to do |format|
      if @comment.user_id = current_user.id  
        @comment.update(comment_params)
        flash.now[:notice] = 'Comment was successfully updated.'
        format.js { render :index }
      else
        flash.now[:notice] = 'The updating attempt failed.'
        format.js { render :edit }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      flash.now[:notice] = 'The comment was successfully deleted.'
      format.js { render :index }
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
  def set_blog
    @blog = Blog.find(params[:blog_id])
  end

end