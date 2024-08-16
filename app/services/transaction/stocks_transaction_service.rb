module Transaction
  class StocksTransactionService < TransactionService
    def initialize(wallet)
      @wallet = wallet
    end
    
    def stock_trade(lot_purchased, symbol)
      stock_info = StockService.new.stock_price(symbol)
      if stock_info[:internal_data].present?
        open_price = stock_info[:stock_data][0]['open']
        amount = (lot_purchased * 100) * open_price.to_d
        ActiveRecord::Base.transaction(isolation: :serializable) do 
          raise InsufficientFundsError, 'Insufficient funds' if @wallet.balance < amount
          
          stock_id = stock_info[:internal_data][:id]
          target_wallet = Wallet.find_by(walletable_id: stock_id, walletable_type: 'Stock')

          send_from_wallet = {
            wallet: @wallet,
            transaction_category: WalletTransaction::TR_BUY,
            amount: amount,
            source_wallet: @wallet,
            target_wallet: target_wallet
          }
          create_debit_transaction(send_from_wallet)
    
          receive_from_wallet = {
            wallet: target_wallet,
            transaction_category: WalletTransaction::TR_SELL,
            amount: amount,
            source_wallet: @wallet,
            target_wallet: target_wallet,
          }
          create_credit_transaction(receive_from_wallet)

          owner_type = @wallet[:walletable_type]
          ownership = owner_type.constantize.find_by(wallet: @wallet)

          update_shares_ownership = StockOwnershipService.new(ownership)
          update_shares_ownership.add_shares(lot_purchased, stock_id)
          shares_bal = update_shares_ownership
    
          ActiveRecord::Base.connection.commit_db_transaction
          { amount: amount, shares_bal: shares_bal }
        rescue StandardError => e
          # Rollback in case of any error
          ActiveRecord::Base.connection.rollback_db_transaction
          raise e
        end
      else
        { status: 'stock price not found' }
      end
    end
  end
end