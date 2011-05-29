class CommentsController < ApplicationController
before_filter :find_comment, :only => [:show,:edit,:update,:destroy]

  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
    @post = @comment.post
  end

  def new
    @comment = Comment.new
  end

  def edit
    @post=@comment.post
  end

  def create
    @comment = Comment.new(params[:comment])
    if signed_in?
    @comment.user_id=current_user.id
    else
    @comment.user_id=0
    end
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@comment, :notice => 'Comment was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
    end
  end
private
    def find_comment
      @comment = Comment.find(params[:id])
      redirect_to(root_path) unless current_user?(@comment.user)
    end
end

