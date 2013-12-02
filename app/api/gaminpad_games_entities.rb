module GaminpadGamesEntities
  
  class GameEntity < Grape::Entity
    expose :id
    expose :title
    expose :status
    expose :player, :as => :owner, :using => PlayerEntity
    expose :last_played
    expose :players, :using => PlayerEntity
  end
  
end