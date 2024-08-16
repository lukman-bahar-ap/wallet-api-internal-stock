class Team < ActiveRecord::Base
  has_one :wallet, as: :walletable, dependent: :destroy, class_name: 'Transaction::Wallet'
  has_many :stock_ownerships, as: :stock_owner, dependent: :destroy
  has_one :user_login, as: :loginable, dependent: :destroy
  has_many :team_members, dependent: :destroy

  after_create :create_wallet

  private

  def create_wallet
    Transaction::Wallet.create!(walletable: self, balance: 0)
  end
end
  