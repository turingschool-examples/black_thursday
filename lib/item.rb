require 'bigdecimal'

# Item
class Item
  attr_reader   :id,
                :unit_price_to_dollars,
                :created_at,
                :updated_at,
                :merchant_id
                
  attr_accessor :name,
                :description,
                :unit_price

  def initialize(item, parent = nil)
    @id = item[:id].to_i
    @name = item[:name]
    @description = item[:description]
    @unit_price = BigDecimal(item[:unit_price])
    @unit_price_to_dollars = @unit_price.to_f
    @created_at = item[:created_at]
    @updated_at = item[:updated_at]
    @merchant_id = item[:merchant_id].to_i
  end
end
