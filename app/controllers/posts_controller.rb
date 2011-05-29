class PostsController < ApplicationController
  before_filter :find_post, :only => [:edit,:update,:destroy]
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments=@post.comments
    @comment=Comment.new
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
    @post.rating = 0
    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
    end
  end

  def vote
    respond_to do |format|
      format.js do
          post=Post.find(params[:id])
          @rating="You already have voted"
          unless cookies[:vote] || (signed_in?&&!current_user.vote)
            vote = params[:vote]=="1"?1:-1
            cookies[:vote]=1
            post.rating+=vote
            post.save
            @rating=post.rating
          end
      end
    end
  end

private
    def find_post
      @post = Post.find(params[:id])
      redirect_to(root_path) unless current_user?(@post.user)
    end
end

