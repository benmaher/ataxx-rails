class CreateAtaxxGamePlayer < ActiveRecord::Migration
  def up
    create_table :ataxx_game_player do |t|
      t.integer :game_id
      t.integer :user_id
      t.timestamps
    end
  end

  def down
  end
end
