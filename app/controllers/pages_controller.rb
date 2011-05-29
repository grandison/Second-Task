class PagesController < ApplicationController
  def home
    @title= "Home"
    rating_min = 4
    @posts= Post.where("rating >= ?",[rating_min]).order("rating DESC, created_at DESC")
  end
  def other_news
    @title= "Other news"
    @posts= Post.order("rating DESC, created_at DESC").all
    render 'home'
  end
  def contact
    @title= "Contact"
  end

  def about
    @title= "About"
  end

end

