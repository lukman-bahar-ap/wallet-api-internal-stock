module Api
  class StocksController < ApplicationController
    before_action :authenticate_request
    
    def show
      stock_symbol = params[:symbol]
      stock_price = StockService.new.stock_price(stock_symbol)
  
      message = success_response.merge(message: 'Stock not found')
      if stock_price
        message = detail_response(symbol: stock_symbol, data: stock_price)
      end
      render json: message
    end
  
    def index
      stock_prices = StockService.new.list
      render json: list_response(stock_prices)
    end
  
    def all
      all_prices = StockService.new.all_outer_stocks
      render json: list_response(all_prices)
    end
  end
end

