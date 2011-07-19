class CommentsController < ApplicationController

  before_filter :find_comment, :only => [:show,:edit,:update,:destroy]

  def index
    @comments = Comment.all
    respond_to do |format|
      format.html
      format.xml {render :xml => @comments}
    end
  end

  def show
    @post = @comment.post
    respond_to do |format|
      format.html
      format.xml {render :xml => @comment}
    end
  end


  def edit
    @post=@comment.post
  end

  def create
    @comment = Comment.new(params[:comment])
    @post=@comment.post
    @comment.approve=0
    if logged_in?
      @comment.user_id=current_user.id
    else
      @comment.user_id=0
    end
    unless verify_recaptcha
      redirect_to(@post, :notice => 'wrong captcha')
    else
      if @comment.save
        redirect_to(@comment, :notice => 'Comment was successfully created.')
      else
      render :action => "new"
      end
    end
  end

  def update
    if @comment.update_attributes(params[:comment])
      redirect_to(@comment, :notice => 'Comment was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @comment.destroy
    redirect_to(comments_url)
  end

  def approve
    @class="approve"
    respond_to do |format|
      format.js do
        @comment=Comment.find(params[:id])
        @comment.approve=1
        @comment.save
      end
    end
  end

  def disapprove
    @class="disapprove"
    respond_to do |format|
      format.js do
        @comment=Comment.find(params[:id])
        @comment.approve=-1
        @comment.save
        render :action => :approve
      end
    end
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

end

