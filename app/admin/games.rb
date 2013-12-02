ActiveAdmin.register Game do
  
  show do
    attributes_table do
  		row :id
  		row :title
  		row :status
  		row :last_played
  		row :game_end
  		h4 "Players"
  		ol game.players.collect{|p| li p.username}
  	end
  	
	end
	
  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :title
      f.input :status
      f.input :players
    end
    f.actions
  end
  
  
end
