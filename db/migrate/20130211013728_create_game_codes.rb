class CreateGameCodes < ActiveRecord::Migration
  def change
    create_table :game_codes do |t|
      t.string :name

      t.timestamps
    end
  end
end
