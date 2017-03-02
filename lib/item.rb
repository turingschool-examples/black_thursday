require 'pry'
require "bigdecimal"
require "date"
require_relative "../lib/item_data_access"

class Item
  include ItemDataAccess

  def unit_price_to_dollars
    unit_price.to_f
  end

  def merchant
    parent.parent.merchants.find_by_id(merchant_id)
  end
end
