class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :avatar
      t.string :encrypted_password
      t.string :remember_token
      t.integer :role, default: 0

      t.timestamps null: false
    end
  end
end
