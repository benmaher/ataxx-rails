class CreateUser < ActiveRecord::Migration
  def up
    create_table :user do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.timestamps
    end
  end

  def down
  end
end
