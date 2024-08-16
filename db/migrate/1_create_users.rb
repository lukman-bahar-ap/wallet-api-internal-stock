class CreateUsers < ActiveRecord::Migration[6.1]
  def up
    create_table :users do |t|
      t.string :customer_name, limit: 50, null: false
      t.string :email, limit: 100, null: false
      t.timestamps
    end

    add_index :users, :customer_name, unique: true
    add_index :users, :email, unique: true
  end

  def down
    remove_index :users, :customer_name
    remove_index :users, :email
    drop_table :users
  end
end
  