module Transaction
  class TransactionService
    def create_debit_transaction(transaction)
      Debit.create!(
        transaction_type: Debit::DEBIT,
        wallet: transaction[:wallet],
        transaction_category: transaction[:transaction_category],
        amount: transaction[:amount],
        source_wallet: transaction[:source_wallet],
        target_wallet: transaction[:target_wallet]
      )
    end
  
    def create_credit_transaction(transaction)
      Credit.create!(
        transaction_type: Credit::CREDIT,
        wallet: transaction[:wallet],
        transaction_category: transaction[:transaction_category],
        amount: transaction[:amount],
        source_wallet: transaction[:source_wallet],
        target_wallet: transaction[:target_wallet]
      )
    end

    class InsufficientFundsError < StandardError; end
  end
end