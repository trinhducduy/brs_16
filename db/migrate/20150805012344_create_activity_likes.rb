class CreateActivityLikes < ActiveRecord::Migration
  def change
    create_table :activity_likes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :activity, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
