class UsersController < ApplicationController
  before_filter :login_required, :only => [:index, :edit, :update]
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
  def edit
    @title = "Edit user"
  end
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      redirect_back_or_default('/', :notice => "Thanks for signing up!  We're sending you an email with your activation code.")
    else
      flash.now[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end


  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      redirect_to '/login', :notice => "Signup complete! Please sign in to continue."
    when params[:activation_code].blank?
      redirect_back_or_default('/', :flash => { :error => "The activation code was missing.  Please follow the URL from your email." })
    else
      redirect_back_or_default('/', :flash => { :error  => "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in." })
    end
  end

  def sign_in?
    authorized?
  end
  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user==@user
    end
end

