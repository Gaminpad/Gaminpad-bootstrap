module GaminpadCore
  
  
  class APICore < Grape::API
    
    version 'v1', using: :path
    format :json
    rescue_from :all, :backtrace => true
    
    # Load modules
    include GaminpadAuth
    include GaminpadGames
    
    helpers do
    end
    
    before do
    end

    resource :ping do
      desc 'Test purpose. Sends a pong response.'
      get '/' do
        # APICore.logger.info "ping - self -> #{self.inspect}"
        { pong: "true"}
      end
    end
    
  end
  
end