# require 'bigdecimal'

class Item # < ItemRepo

  attr_reader :name, :parent, :merchant_id, :item_id, :description, :unit_price,
              :created_at, :updated_at

  def initialize(data, parent)
    @name = data[:name]
    @parent = parent
    @merchant_id = data[:merchant_id]
    @item_id = data[:id]
    @description = data[:description]
    @unit_price = BigDecimal.new(data[:unit_price])/100
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def merchant
    parent.merchant(merchant_id)
  end

  def unit_price_to_dollars
    @unit_price.round(2).to_f
  end

end


# description - returns the description of the item
# unit_price - returns the price of the item formatted as a BigDecimal
# created_at - returns a Time instance for the date the item was first created
# updated_at - returns a Time instance for the date the item was last modified
