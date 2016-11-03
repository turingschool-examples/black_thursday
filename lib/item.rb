require 'bigdecimal'
require 'time'

class Item
  attr_reader   :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id,
                :parent

  def initialize(item_hash, parent=nil)
    @id = item_hash[:id].to_i
    @name = item_hash[:name]
    @description = item_hash[:description]
    @unit_price = BigDecimal(format_unit_price(item_hash[:unit_price]))
    @created_at = Time.parse(item_hash[:created_at])
    @updated_at = Time.parse(item_hash[:updated_at])
    @merchant_id = item_hash[:merchant_id]
    @parent = parent
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def merchant
    parent.find_merchant(merchant_id)
  end

  def format_unit_price(price)
    price.chars.insert(-3, ".").join
  end

end
