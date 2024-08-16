module Transaction
  class Debit < WalletTransaction 
    DEBIT_CATEGORY = [ TR_WITHDRAW, TR_SEND, TR_BUY ].freeze

    validate :validate_debit
    validates_presence_of :target_wallet, if: :two_way_wallet_tr?
    validate :null_target_wallet, if: :withdraw?

    private

    def two_way_wallet_tr?
      transaction_category == TR_SEND || transaction_category == TR_BUY
    end

    def withdraw?
      transaction_category == TR_WITHDRAW
    end

    def debit_category?
      DEBIT_CATEGORY.include?(transaction_category)
    end

    def validate_debit
      errors.add(:transaction_type, "#{transaction_type}, must be debit transaction") unless TR_DEBIT == transaction_type
      errors.add(:transaction_category, "must be one of #{DEBIT_CATEGORY.join(', ')}") unless debit_category?
    end

    def null_target_wallet
      errors.add(:target_wallet, " #{target_wallet} must be nil for debit transactions") if target_wallet.present?
    end
  end
end