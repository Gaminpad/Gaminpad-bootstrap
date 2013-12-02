include GaminpadGamesEntities

module GaminpadGames

  def self.included(base)
    base.class_eval do
      
      helpers GaminpadGamesHelpers
    
      resource :games do
        
        desc 'List players games'
        get '/' do
          verify_token
          @games = current_player.games
          present @games, with: GaminpadGamesEntities::GameEntity
        end
        
        desc 'Create a game'
        params do
          optional :title, type: String, regexp: /^[0-9a-zA-Z\s_-]{3,}$/, desc: "Game Title"
        end
        post '/' do
          verify_token
          @game = Game.new(:player => current_player, :title => params[:title])
          @game.players << current_player
          if @game.save
            present @game, with: GaminpadGamesEntities::GameEntity
          else
            error!("Error creating game: #{@game.errors.as_json}", 400)
          end
        end
        
        desc 'Delete a Game'
        params do
          requires :id, type: String, desc: "Game Id"
        end
        delete ':id' do
          verify_token
          @game = current_player.games_owned.find_by_id(params[:id])
          if @game && @game.destroy
            { :game => @game.id, :status => :deleted }
          else
            error!("Error deleting game with Id(#{params[:id]})", 400)
          end
        end
        
        namespace '/:game_id' do
          
          resource :players do
            desc 'Adds a player to a game'
            post ':id' do
              @game = Game.find_by_id(params[:game_id])
              @player = Player.find_by_id(params[:id])
              if @game && @player
                if !@game.joined?(@player)
                  @game.players << @player
                  { :game => @game.id, :player => @player.id, :status => :joined }
                else
                  error!("Player(#{@player.id}) is already in the Game(#{@game.id})", 400)
                end
              else
                error!("Can't find Player(#{params[:id]}) or Game(#{params[:game_id]})", 404)
              end
            end
          end
          
          resource :players do
            desc 'Removes a player from a game'
            delete ':id' do
              @game = Game.find_by_id(params[:game_id])
              @player = @game.players.find_by_id(params[:id])
              if @game && @player
                if @game.players.delete(@player)
                  { :game => @game.id, :player => @player.id, :status => :deleted }
                else
                  error!("Can't delete Player(#{@player.id}) in the Game(#{@game.id})", 400)
                end
              else
                error!("Can't find Player(#{params[:id]}) in the Game(#{params[:game_id]})", 404)
              end
            end
          end
          
          
        end
        
      end

    end
  end

end