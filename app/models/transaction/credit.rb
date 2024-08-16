module Transaction
  class Credit < WalletTransaction 
    CREDIT = TR_CREDIT
    CREDIT_CATEGORY = [ TR_DEPOSIT, TR_RECEIVE, TR_SELL ].freeze
    validate :validate_credit
    validates_presence_of :source_wallet, if: :two_way_wallet_tr?
    validate :null_source_wallet, if: :deposit?

    private

    def two_way_wallet_tr?
      transaction_category == TR_RECEIVE || transaction_category == TR_SELL
    end

    def deposit?
      transaction_category == TR_DEPOSIT
    end

    def credit_category?
      CREDIT_CATEGORY.include?(transaction_category)
    end

    def null_source_wallet
      errors.add(:source_wallet, "#{source_wallet} must be nil for deposit transactions") if source_wallet.present?
    end

    def validate_credit
      errors.add(:transaction_type, "#{transaction_type} == #{CREDIT} => must be credit transaction") unless CREDIT == transaction_type
      errors.add(:transaction_category, "#{transaction_category} must be one of #{CREDIT_CATEGORY.join(', ')}") unless credit_category?
    end

  end
end