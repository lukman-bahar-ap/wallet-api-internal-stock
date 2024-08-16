class Api::Transaction::WalletTransactionController < ApplicationController
  before_action :authenticate_request

  def deposit
    wallet = walletable
    service = Transaction::WalletService.new(wallet)

    message = failed_response.merge(message: 'Invalid amount', error: :unprocessable_entity)
    if deposit_validate?
      service.wallet_deposit(params[:amount].to_d)
      message = success_response.merge(message: 'Topup successful')
    end
    render json: message
  end
  
  def withdraw
    wallet = walletable
    service = Transaction::WalletService.new(wallet)

    message = failed_response.merge(
      message: 'Invalid amount or insufficient balance', 
      error: :unprocessable_entity
    )
    if withdraw_validate?(wallet.balance)
      service.wallet_withdraw(params[:amount].to_d)
      message = success_response.merge(message: 'Withdrawal successful')
    end
    render json: message
  end

  def transfer
    wallet = walletable
    service = Transaction::WalletService.new(wallet)

    message = failed_response.merge(message: 'Invalid amount', error: :unprocessable_entity)
    if transfer_validate?(wallet)
      target_wallet =  Transaction::Wallet.find(params[:target_wallet_id])
      service.wallet_transfer(params[:amount].to_d, target_wallet)
      message = success_response.merge(message: 'Transfer successful')
    end
    render json: message
  end

  def purchase
    lot = params[:lot].to_i
    symbol = params[:symbol]
    wallet = walletable

    service = Transaction::StocksTransactionService.new(wallet)

    message = failed_response.merge(
      message: 'Invalid lot or insufficient balance', 
      error: :unprocessable_entity
    )
    if purchase_validate?(wallet)
      service.stock_trade(lot, symbol)
      message = success_response.merge(message: 'Transaction successful')
    end
    render json: message
  end

  private

  def purchase_validate?(wallet)
    params[:symbol].present? && 
    wallet.balance >= params[:amount].to_d && 
    wallet.walletable_type != 'Stock' && 
    params[:lot].to_i > 0
  end

  def transfer_validate?(wallet)
    params[:amount].to_f.positive? && wallet.id.present? && params[:target_wallet_id].present?
  end

  def withdraw_validate?(balance)
    params[:amount].to_f.positive? && balance >= params[:amount].to_d
  end

  def deposit_validate?
    params[:amount].to_f.positive? && params[:source_wallet].nil?
  end

  def walletable
    current_login.loginable.wallet
  end
end
