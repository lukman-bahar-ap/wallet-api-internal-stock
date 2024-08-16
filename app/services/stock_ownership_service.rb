class StockOwnershipService
  def initialize(stock_owner)
    @stock_owner = stock_owner
  end

  def add_shares(lot_purchased, stock_id)
    stock_ownership = find_by_entity_stock(stock_id)
    updated_shares = lot_purchased
    if stock_ownership.present?
      updated_shares = stock_ownership[:shares] + lot_purchased
      stock_ownership.update(
        shares: updated_shares
      )
    else
      StockOwnership.create(
        stock_owner: @stock_owner,
        stock_id: stock_id,
        shares: updated_shares,
      )
    end
    updated_shares
  end

  def find_by_entity_stock(stock_id)
    StockOwnership.find_by(stock_owner: @stock_owner, stock_id: stock_id)
  end

end