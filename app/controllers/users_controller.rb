class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]

  def index
    @users = User.paginate(:page => params[:page])
    @title = "All users"
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(:page => params[:page])
    @title = @user.name
    @post =Post.new
    @categories=Category.all.map{|cat| [cat.name,cat.id]}
  end

  def new
    @user = User.new
    @title="Sign up"
  end

  def edit
    @title = "Edit user"
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
      else
        @title = "Sign up"
        format.html { render :action => "new"}
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'Profile updated.') }
      else
        @title = "Edit user"
        format.html { render :action => "edit" }
      end
    end
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end

