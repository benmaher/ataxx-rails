class User < ActiveRecord::Base
  attr_accessible :username, :first_name, :last_name

  has_many :ataxx_players
  has_many :ataxx_sessions, through: :ataxx_players

end
