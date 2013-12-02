module GaminpadAuthEntities
  
  class PlayerEntity < Grape::Entity
    expose :id
    expose :username
    expose :created_at
  end
  
end