class CreateStocks < ActiveRecord::Migration[6.1]
  def up
    create_table :stocks do |t|
      t.string :stock_name, limit: 100, null: false
      t.string :symbol, limit: 10, null: false
      t.timestamps
    end

    add_index :stocks, :stock_name, unique: true
    add_index :stocks, :symbol, unique: true
  end

  def down
    remove_index :stock_name, :symbol
    remove_index :stocks, :symbol
    drop_table :stocks
  end
end
  