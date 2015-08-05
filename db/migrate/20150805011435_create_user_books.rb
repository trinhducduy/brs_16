class CreateUserBooks < ActiveRecord::Migration
  def change
    create_table :user_books do |t|
      t.boolean :favored, default: false
      t.integer :status, default: 0
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
