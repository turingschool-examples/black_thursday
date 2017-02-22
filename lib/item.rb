require 'bigdecimal'

class Item

  attr_reader :item_hash

  def initialize(hash)
    @item_hash = hash
  end

  def name
    item_hash[:name]
  end

  def id
    item_hash[:id]
  end

  def description
    item_hash[:description]
  end

  def unit_price
    BigDecimal.new(item_hash[:unit_price])
  end

  def created_at
    item_hash[:created_at]
  end

  def updated_at
    item_hash[:updated_at]
  end

  def merchant_id
    item_hash[:merchant_id]
  end

  def unit_price_to_dollars
    unit_price.to_f / 100
  end
end

# Item
#
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
# We create an instance like this:
