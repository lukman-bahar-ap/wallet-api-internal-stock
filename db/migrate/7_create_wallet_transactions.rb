class CreateWalletTransactions < ActiveRecord::Migration[6.1]
  def up
    create_table :wallet_transactions do |t|
      t.references :wallet, foreign_key: { to_table: :wallets }
      t.integer :transaction_type, limit: 1, null: false, default: 0 #('debit','credit')
      t.integer :transaction_category, limit: 1, null: false, default: 0 #('topup','withdraw','send','receive','buy','sell')
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.references :source_wallet, foreign_key: { to_table: :wallets }
      t.references :target_wallet, foreign_key: { to_table: :wallets }
      t.integer :qty_transaction_stock, null: true #optional if transaction buy/sell stock    
      t.timestamps
    end
  end

  def down
    drop_table :wallet_transactions
  end
end
  