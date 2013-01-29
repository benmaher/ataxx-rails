class CreateAtaxxBoard < ActiveRecord::Migration
  def up
    create_table :ataxx_board do |t|
      t.string :name
      t.integer :x_size
      t.integer :y_size
      t.text :blocked_locations
      t.text :initial_pieces
      t.timestamps
    end
  end

  def down
  end
end
