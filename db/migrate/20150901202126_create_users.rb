class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :guid
      t.string :email
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
    add_index :users, :guid
    add_index :users, :email
  end
end
