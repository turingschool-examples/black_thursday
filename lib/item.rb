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
    @unit_price = data[:unit_price]
    @created_at = Time.now
    @updated_at = Time.now
  end

  def merchant
    parent.merchant(merchant_id)
  end

end


# description - returns the description of the item
# unit_price - returns the price of the item formatted as a BigDecimal
# created_at - returns a Time instance for the date the item was first created
# updated_at - returns a Time instance for the date the item was last modified
