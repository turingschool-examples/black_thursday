class Item
  attr_reader :item_attributes

  def initialize(attributes)
    @item_attributes = attributes
    @item_attributes[:id] = item_attributes[:id].to_i
    @item_attributes[:merchant_id] = item_attributes[:merchant_id].to_i
  end

  def unit_price_to_dollars
    item_attributes[:unit_price].to_f
  end
end
