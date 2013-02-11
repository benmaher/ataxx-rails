class DropAtaxxBoard < ActiveRecord::Migration
  def up
    drop_table :ataxx_boards
  end

  def down
  end
end
