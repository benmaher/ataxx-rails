class CreateAtaxxVersions < ActiveRecord::Migration
  def change
    create_table :ataxx_versions do |t|
      t.string :name
      t.integer :code
      t.integer :game_id

      t.timestamps
    end
  end
end
