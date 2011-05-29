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
          if signed_in?
            user_id = current_user.id
          else
            user_id = 0
          end
          @post_id=params[:id]
          post=Post.find(@post_id)
          is_vote=UserVotes.where(:user_id=>user_id,:post_id=>@post_id)
          @rating="You already have voted"
          unless (cookies[@post_id] || (signed_in?&&is_vote))
            vote = params[:vote]=="1"?1:-1
            cookies[@post_id]=1
            post.rating+=vote
            post.save
            @rating=post.rating
            if signed_in?
              UserVotes.create(:user_id=>user_id,:post_id=>@post_id)
            end
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

