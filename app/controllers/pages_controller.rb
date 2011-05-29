class PagesController < ApplicationController
  def home
    @title= "Home"
    rating_min = 400
    @posts= Post.where("rating >= ?",[rating_min]).
                  order("rating DESC, created_at DESC").
                  paginate(:per_page => 10,:page => params[:page])
  end
  def other_news
    @title= "Other news"
    @posts= Post.order("rating DESC, created_at DESC").
                  all.
                  paginate(:per_page => 10,:page => params[:page])
    render 'home'
  end
  def contact
    @title= "Contact"
  end

  def about
    @title= "About"
  end

end

