class AtaxxVersion < ActiveRecord::Base
  attr_accessible :code, :game_id, :name

  belongs_to :game
end
