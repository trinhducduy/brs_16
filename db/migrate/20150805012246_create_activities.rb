class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :action_type
      t.integer :target_id
      t.string :target_name
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
