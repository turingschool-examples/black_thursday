require 'pry'

class Item

  def initialize
  end
end

# Item
# The Item instance offers the following methods:

# id - returns the integer id of the item
# name - returns the name of the item
# description - returns the description of the item
# unit_price - returns the price of the item formatted as a BigDecimal
# created_at - returns a Time instance for the date the item was first created
# updated_at - returns a Time instance for the date the item was last modified
# merchant_id - returns the integer merchant id of the item
# It also offers the following method:

# unit_price_to_dollars - returns the price of the item in dollars formatted as a Float