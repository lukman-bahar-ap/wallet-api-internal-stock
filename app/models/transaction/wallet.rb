module Transaction
  class Wallet < ActiveRecord::Base
    belongs_to :walletable, polymorphic: true
    has_many :wallet_transactions

    def balance_calculation
      credits = wallet_transactions.where(transaction_type: 'credit').sum(:amount)
      debits = wallet_transactions.where(transaction_type: 'debit').sum(:amount)
      self.balance = credits - debits
      self.save
    end
  end
end
