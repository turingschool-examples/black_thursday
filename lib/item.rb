require 'bigdecimal'

class Item
  attr_reader   :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id,
                :parent

  def initialize(item_hash, parent = nil)
    @id = item_hash[:id]
    @name = item_hash[:name]
    @description = item_hash[:description]
    @unit_price = BigDecimal.new(item_hash[:unit_price], 4)
    @created_at = item_hash[:created_at]
    @updated_at = item_hash[:updated_at]
    @merchant_id = item_hash[:merchant_id]
    @parents = parent
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def merchant
    parent.find_merchant(merchant_id)
  end
end
