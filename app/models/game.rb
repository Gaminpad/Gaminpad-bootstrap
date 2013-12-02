class Game < ActiveRecord::Base

  attr_accessible :title, :status, :player, :player_ids
  
  has_and_belongs_to_many :players, :join_table => :game_joins
  belongs_to :player, :foreign_key => 'owner_id', :inverse_of => :games_owned
  
  validates :player, :presence => true
  validates :title, :presence => false, :format => /^[0-9a-zA-Z\s_-]{3,}$/, :on => :create
  
  def joined?(player)
    self.players.exists?(player)
  end
  
end
