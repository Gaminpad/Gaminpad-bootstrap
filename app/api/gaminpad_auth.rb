include GaminpadAuthEntities

module GaminpadAuth

  def self.included(base)
    base.class_eval do

      helpers GaminpadAuthHelpers

      resource :tokens do
        
        desc 'Create new token through email/password authentication'
        params do
          requires :email, type: String
          requires :password, type: String
        end
        post '/' do
          current_player = authenticate_player!
          if current_player
            {
              authorized: 'ok',
              token: current_player.authentication_token
            }
          end
        end
        
        desc 'Check token validity.'
        get '/' do
          verify_token
          {
            player: current_player
          }
        end
      end

    end
  end

end