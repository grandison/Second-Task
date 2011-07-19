class PostsController < ApplicationController

  before_filter :admin?, :only => [:edit, :update, :new, :destroy, :create]
  before_filter :find_post, :only => [:show,:edit,:update,:destroy]
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'

  def index
    @posts = Post.all
    respond_to do |format|
      format.html
      format.xml {render :xml => @posts}
    end
  end

  def show
    @comments=@post.comments
    @comment=Comment.new
    respond_to do |format|
      format.html
      format.xml {render :xml => @post}
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @categories=Category.all.map{|cat| [cat.name,cat.id]}
  end

  def create
    @post = Post.new(params[:post])
    @post.tag_list=params[:tag_list]
    @post.user_id = current_user.id
    @post.rating = 0
    if @post.save
      redirect_to(@post, :notice => 'Post was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @post.tag_list=params[:as_values_tag_list]
    if @post.update_attributes(params[:post])
      redirect_to(@post, :notice => 'Post was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @post.destroy
    redirect_to(posts_url)
  end

  def vote
    respond_to do |format|
      format.js do
          if logged_in?
            user_id = current_user.id
          else
            user_id = 0
          end
          @post_id=params[:id]
          post=Post.find(@post_id)
          is_vote=UserVotes.where(:user_id=>user_id,:post_id=>@post_id)
          @rating="You already have voted"
          unless (cookies[@post_id] || (logged_in?&&is_vote.any?))
            vote = params[:vote]=="1"?1:-1
            cookies[@post_id]=1
            post.rating+=vote
            post.save!
            @rating=post.rating
            if logged_in?
              UserVotes.create(:user_id=>user_id,:post_id=>@post_id)
            end
          end
        end
    end
  end

  private
  def admin?
    return true if current_user&&current_user.admin?
    return false
  end
  def find_post
    @post = Post.find(params[:id])
  end
end

