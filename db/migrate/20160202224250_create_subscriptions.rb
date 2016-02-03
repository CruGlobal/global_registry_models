class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :entity_type_id

      t.timestamps null: false
    end
  end
end
