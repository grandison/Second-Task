class PagesController < ApplicationController
  def home
    @title= "Home"
    @posts= Post.scoped
    @posts= @posts.topic(params[:topic]) if params[:topic].present?
    @posts= @posts.text(params[:text]) if params[:text].present?
    @posts= @posts.cat_id(params[:category_id]) if params[:category_id].present?
    @posts= @posts.tagged_with(params[:post][:tag_list]) if params[:post].present?&&params[:post][:tag_list].present?
    if params[:order].present?
      @posts = @posts.order("rating #{params[:order]}")
    else
      @posts = @posts.order("rating DESC")
    end
    @posts=colorize(@posts,:topic,params[:topic]) if params[:topic].present?
    @posts=colorize(@posts,:text,params[:text]) if params[:text].present?
    @posts=@posts.paginate(:per_page => 10,:page => params[:page])
    @categories=Category.all
  end

  def contact
    @title= "Contact"
  end

  def about
    @title= "About"
  end

  private
  def colorize (scope,field,replace)
    for p in scope
      p.send(field).gsub!(/#{replace}/i,"<font style='background-color:#FFFF00'>"+replace.downcase+"</font>") do |match|
      end
    end
  end
end

