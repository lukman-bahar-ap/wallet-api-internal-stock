module Transaction
  class WalletTransaction < ActiveRecord::Base
    belongs_to :wallet
    belongs_to :source_wallet, class_name: 'Wallet', optional: true
    belongs_to :target_wallet, class_name: 'Wallet', optional: true
  
    TR_DEBIT = 1.freeze
    TR_CREDIT = 2.freeze

    TR_DEPOSIT = 1.freeze
    TR_WITHDRAW = 2.freeze
    TR_SEND= 3.freeze
    TR_RECEIVE = 4.freeze
    TR_BUY = 5.freeze
    TR_SELL = 6.freeze

    TRANSACTION_TYPE = {
      tr_debit: TR_DEBIT,
      tr_credit: TR_CREDIT,
    }.freeze
  
    TRANSACTION_CATEGORY = {
      tr_deposit: TR_DEPOSIT,
      tr_withdraw: TR_WITHDRAW,
      tr_send: TR_SEND,
      tr_receive: TR_RECEIVE,
      tr_buy: TR_BUY,
      tr_sell: TR_SELL
    }.freeze
  
    enum transaction_type: TRANSACTION_TYPE
    enum transaction_category: TRANSACTION_CATEGORY

    validates :transaction_category, inclusion: { in:TRANSACTION_CATEGORY.keys, message: "Invalid category=#{self.transaction_category}. Must be one of: #{TRANSACTION_CATEGORY.keys.join(', ')}" }
    validates :amount, presence: true, numericality: { greater_than: 0.00 }
    after_create :update_wallet_balance

    def update_wallet_balance
      wallet.balance_calculation
    end

  end  
end
