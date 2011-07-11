class PagesController < ApplicationController
  def home
    @title= "Home"
    @posts= Post.scoped
    @posts= @posts.topic(params[:topic]) if params[:topic].present?
    @posts= @posts.text(params[:text]) if params[:text].present?
    @posts= @posts.cat_id(params[:category_id]) if params[:category_id].present?
    @posts = @posts.order("posts.updated_at #{params[:order]}")
    @posts=@posts.paginate(:per_page => 10,:page => params[:page])
    @categories=Category.all
  end
  def contact
    @title= "Contact"
  end

  def about
    @title= "About"
  end

end

