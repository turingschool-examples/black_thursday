require 'csv'

class Item
  attr_reader :name, :description, :unit_price, :created_at, :updated_at

  def initialize(item_hash)
    @name = item_hash[:name]
    @description = item_hash[:description]
    @unit_price = item_hash[:unit_price]
    @created_at = item_hash[:created_at]
    @updated_at = item_hash[:updated_at]
  end


  # The Item instance offers the following methods:
  #
  # id - returns the integer id of the item
  # name - returns the name of the item
  # description - returns the description of the item
  # unit_price - returns the price of the item formatted as a BigDecimal
  # created_at - returns a Time instance for the date the item was first created
  # updated_at - returns a Time instance for the date the item was last modified
  # merchant_id - returns the integer merchant id of the item
  # It also offers the following method:
  #
  # unit_price_to_dollars - returns the price of the item in dollars formatted as a Float

end
