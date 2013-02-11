class DropAtaxxGamePlayers < ActiveRecord::Migration
  def up
    drop_table :ataxx_game_players
  end

  def down
  end
end
