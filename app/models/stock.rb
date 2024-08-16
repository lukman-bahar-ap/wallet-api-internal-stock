class Stock < ActiveRecord::Base
  has_one :wallet, as: :walletable, dependent: :destroy, class_name: 'Transaction::Wallet'
  has_many :stock_ownerships, dependent: :destroy

  after_create :create_wallet

  private

  def create_wallet
    Transaction::Wallet.create!(walletable: self, balance: 0)
  end
end
  