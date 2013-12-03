class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
  	render :file => 'public/landing-app', :layout => false
  end
  
  def api_index
  	render :file => 'public/landing-api', :layout => false
  end
  
end
