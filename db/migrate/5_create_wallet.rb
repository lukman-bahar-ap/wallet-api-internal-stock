class CreateWallet < ActiveRecord::Migration[6.1]
  def up
    create_table :wallets do |t|
      t.references :walletable, polymorphic: true, index: true, limit: 25
      t.decimal :balance, precision: 15, scale: 2, default: 0
      t.timestamps
    end
  end

  def down
    add_index :wallets, [:walletable_type, :walletable_id]
    drop_table :wallets
  end
end
  