class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :owner_id #player
      t.string :title, :limit => 50
      t.string :status, :limit => 10
      t.datetime :last_played
      t.datetime :game_end
      t.timestamps
    end
    
    create_table :game_joins do |t|
      t.datetime :created_at
      t.integer :game_id
      t.integer :player_id
    end
    
    add_index :game_joins, :game_id, :unique => false
    add_index :game_joins, :player_id, :unique => false
    
  end
end
