class DropTableAtaxxGames < ActiveRecord::Migration
  def up
    drop_table :ataxx_games
  end

  def down
  end
end
