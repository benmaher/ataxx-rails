class Game < ActiveRecord::Base
  attr_accessible :game_code_id, :name

  belongs_to :game_code
end
