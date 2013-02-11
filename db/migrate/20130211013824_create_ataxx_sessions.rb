class CreateAtaxxSessions < ActiveRecord::Migration
  def change
    create_table :ataxx_sessions do |t|
      t.integer :ataxx_version_id
      t.integer :ataxx_board_id
      t.text :state

      t.timestamps
    end
  end
end
