class CreateAtaxxGame < ActiveRecord::Migration
  def up
    create_table :ataxx_game do |t|
      t.string :name
      t.integer :board_id
      t.text :state
      t.text :moves
      t.integer :turn_player_id
      t.integer :last_turn_time
      t.timestamps
    end
  end

  def down
  end
end
