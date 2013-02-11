class CreateAtaxxBoards < ActiveRecord::Migration
  def change
    create_table :ataxx_boards do |t|
      t.string :name
      t.integer :x_size
      t.integer :y_size

      t.timestamps
    end
  end
end
