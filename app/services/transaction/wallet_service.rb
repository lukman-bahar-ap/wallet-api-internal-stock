module Transaction
  class WalletService < TransactionService
    def initialize(wallet)
      @wallet = wallet
    end
  
    def wallet_deposit(amount)
      ActiveRecord::Base.transaction(isolation: :serializable) do
        create_credit_transaction({
          wallet: @wallet,
          transaction_category: WalletTransaction::TR_DEPOSIT,
          amount: amount,
          source_wallet: nil,
          target_wallet: @wallet
        })
             
        ActiveRecord::Base.connection.commit_db_transaction
      rescue StandardError => e
        # Rollback in case of any error
        ActiveRecord::Base.connection.rollback_db_transaction
        raise e
      end
    end
  
    def wallet_withdraw(amount)
      ActiveRecord::Base.transaction(isolation: :serializable) do
        raise InsufficientFundsError, 'Insufficient funds' if @wallet.balance < amount
  
        create_debit_transaction({
          wallet: @wallet,
          transaction_category: WalletTransaction::TR_WITHDRAW,
          amount: amount,
          source_wallet: @wallet,
          target_wallet: nil
        })

      
        ActiveRecord::Base.connection.commit_db_transaction
      rescue StandardError => e
        # Rollback in case of any error
        ActiveRecord::Base.connection.rollback_db_transaction
        raise e
      end
    end
  
    def wallet_transfer(amount, target_wallet)
      ActiveRecord::Base.transaction(isolation: :serializable) do
        raise InsufficientFundsError, 'Insufficient funds' if @wallet.balance < amount
  
        send_from_wallet = {
          wallet: @wallet,
          transaction_category: WalletTransaction::TR_SEND,
          amount: amount,
          source_wallet: @wallet,
          target_wallet: target_wallet
        }
        create_debit_transaction(send_from_wallet)
  
        receive_from_wallet = {
          wallet: target_wallet,
          transaction_category: WalletTransaction::TR_RECEIVE,
          amount: amount,
          source_wallet: @wallet,
          target_wallet: target_wallet,
        }
        create_credit_transaction(receive_from_wallet)
    
        ActiveRecord::Base.connection.commit_db_transaction
        
      rescue StandardError => e
        # Rollback in case of any error
        ActiveRecord::Base.connection.rollback_db_transaction
        raise e
      end
    end
  
  end
end