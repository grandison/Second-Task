class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthenticatedSystem
  def admin?
    if current_user
      User.first.id==current_user.id
    end
    false
  end
end

