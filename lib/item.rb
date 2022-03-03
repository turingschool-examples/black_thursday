require "bigdecimal"
class Item
  attr_reader :item_attributes

  def initialize(attributes)
    @item_attributes = attributes
    @item_attributes[:id] = item_attributes[:id].to_i
    @item_attributes[:merchant_id] = item_attributes[:merchant_id].to_i
    unit_price_array = item_attributes[:unit_price].split("")
    unit_price_array.insert(-3, ".")
    unit_price_array = unit_price_array.join("")
    @item_attributes[:unit_price] = BigDecimal(unit_price_array.to_f, 4)
  end

  def unit_price_to_dollars
    item_attributes[:unit_price].to_f
  end
end
