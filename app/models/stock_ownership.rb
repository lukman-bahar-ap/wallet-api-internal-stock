class StockOwnership < ActiveRecord::Base
  belongs_to :stock
  belongs_to :stock_owner, polymorphic: true

end
  