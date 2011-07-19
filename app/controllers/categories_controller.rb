class CategoriesController < ApplicationController

  before_filter :admin?, :only => [:edit, :update, :new, :destroy, :create]

  def index
    @categories = Category.all
    respond_to do |format|
      format.html
      format.xml {render :xml => @categories}
    end
  end

  def show
    @category = Category.find(params[:id])
    @posts=@category.posts
    unless @category.children.empty?
      for cat in @category.children
        @posts<<cat.posts
      end
    end
    @posts=@posts.paginate(:per_page => 10,:page => params[:page])
    respond_to do |format|
      format.html
      format.xml {render :xml => @category}
    end
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to(@category, :notice => 'Category was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to(@category, :notice => 'Category was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to(categories_url)
  end

  private

  def admin?
    redirect_to :root unless current_user&&current_user.admin?
  end

end

