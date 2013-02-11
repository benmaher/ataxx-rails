class CreateAtaxxPlayers < ActiveRecord::Migration
  def change
    create_table :ataxx_players do |t|
      t.integer :user_id
      t.integer :ataxx_session_id
      t.integer :number

      t.timestamps
    end
  end
end
