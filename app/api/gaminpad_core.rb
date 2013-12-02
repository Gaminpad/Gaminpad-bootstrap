GP_MODULES_PATH = File.expand_path("../../modules",  __FILE__)

module GaminpadCore
  
  
  class APICore < Grape::API
    
    version 'v1', using: :path
    format :json
    rescue_from :all, :backtrace => true
    
    # Load modules
    include GaminpadAuth
    include GaminpadGames
    
    helpers do
      
      def valid_app_slug
        APICore.logger.info "valid_app_slug - self -> #{self.inspect}"
        @app_slug = request.host.split('.').first
        @app = App.find_by_url_slug(@app_slug)
        if @app.nil?
          error!("Invalid App Slug: #{@app_slug}", 400)
          false
        else
          true
        end
      end
    end
    
    before do
      valid_app_slug
    end

    resource :ping do
      desc 'Test purpose. Sends a pong response.'
      get '/' do
        APICore.logger.info "ping - self -> #{self.inspect}"
        { pong: "true", :app => @app_slug }
      end
    end
    
  end
  
end