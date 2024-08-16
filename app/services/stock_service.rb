class StockService
  def list
    list_stock = Stock.order('stock_name DESC')
    LatestStockPrice.prices(list_stock.pluck(:symbol))
  end

  def stock_price(symbol)
    stock = Stock.find_by(symbol: symbol)
    stock_price = LatestStockPrice.price(stock[:symbol])
    if stock_price.length > 0
      { internal_data: stock, stock_data: stock_price }
    end
  end

  def all_outer_stocks
    LatestStockPrice.price_all
  end
end