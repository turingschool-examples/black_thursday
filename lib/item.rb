require 'bigdecimal'
class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at
  def initialize(item, parent)
    @id = item[:id].to_i
    @name = item[:name]
    @description = item[:description]
    @unit_price = BigDecimal.new(item[:unit_price])/100
    @merchant_id = item[:merchant_id]
    @created_at = item[:created_at]
    @updated_at = item[:updated_at]
    @parent = parent
  end

  def unit_price_to_dollars
    "$" + ("%.2f" % @unit_price
    
  end
end