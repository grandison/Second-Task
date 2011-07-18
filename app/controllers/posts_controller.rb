class PostsController < ApplicationController
  before_filter :admin?, :only => [:edit, :update, :new, :destroy, :create]
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'
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
    @post = Post.find(params[:id])
    @categories=Category.all.map{|cat| [cat.name,cat.id]}
  end

  def create
    @post = Post.new(params[:post])
    @post.tag_list=params[:tag_list]
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
    @post = Post.find(params[:id])
    @post.tag_list=params[:as_values_tag_list]
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
          unless (cookies[@post_id] || (signed_in?&&is_vote.any?))
            vote = params[:vote]=="1"?1:-1
            cookies[@post_id]=1
            post.rating+=vote
            post.save!
            @rating=post.rating
            if signed_in?
              UserVotes.create(:user_id=>user_id,:post_id=>@post_id)
            end
          end
        end
    end
  end

  def tags
    respond_to do |format|
      format.json do
        render :json => Post.tags.map(&:attributes)
      end
    end
  end
  private
  def admin?
    return true if current_user&&current_user.admin?
    return false
  end
end

