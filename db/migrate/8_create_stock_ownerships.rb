class CreateStockOwnerships < ActiveRecord::Migration[6.1]
  def up
    create_table :stock_ownerships do |t|
      t.references :stock, foreign_key: { to_table: :stocks }
      t.references :stock_owner, polymorphic: true, null: false, limit: 25
      t.integer :shares, null: false, default: 0
      t.timestamps
    end
    add_index :stock_ownerships, [:stock_owner_id, :stock_owner_type]
  end

  def down
    remove_index :stock_ownerships, [:stock_owner_id, :stock_owner_type]
    drop_table :stock_ownerships
  end
end
  