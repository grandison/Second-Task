class PagesController < ApplicationController
  def home
    @title= "Home"
    @posts= Post.all
  end

  def contact
    @title= "Contact"
  end

  def about
    @title= "About"
  end

end

