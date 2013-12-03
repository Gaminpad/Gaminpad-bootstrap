class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
  	render :file => 'public/landing-app', :layout => false
  end

end
