#base on documentation https://rapidapi.com/suneetk92/api/latest-stock-price/playground/apiendpoint_2cef5b0e-a44f-48b2-baff-b4bdbacce419
#price, and prices no have api on rapidapi and documentation, so assesment from get price all
require 'uri'
require 'net/http'
require 'json'

module LatestStockPrice
  def self.price(symbol)
    list = price_all
    filtered_stocks = list.select { |hash| symbol == hash['symbol'] }
    filtered_stocks.length > 0 ? filtered_stocks : []
  end

  def self.prices(symbols)
    list = price_all
    filtered_stocks = list.select { |hash| symbols.include?(hash['symbol']) }
    filtered_stocks.length > 0 ? filtered_stocks : []
  end

  def self.price_all
    get_list = list_stocks
    get_list[:status] == 200 ?  get_list[:data] : []
  end

  private

  def self.fetch_data(endpoint)
    uri = URI("https://#{ENV['API_STOCK_PRICE_URL']}#{endpoint}")
    puts uri
    req = Net::HTTP::Get.new(uri)
    req['x-rapidapi-host'] = ENV['API_STOCK_PRICE_URL']
    req['x-rapidapi-key'] = ENV['API_KEY_STOCK_PRICE_URL']

    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(req)
    end
  end

  def self.list_stocks
    response = fetch_data('/any')
    parse_response(response)
  end

  def self.parse_response(response)
  {
    status: 200,
    data: JSON.parse(response.body) 
  }
  rescue JSON::ParserError
    raise "Error parsing response: #{response.body}"
  end
end
