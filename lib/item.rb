require 'bigdecimal'
class Item
  attr_reader :name,
              :id,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id
  def initialize(input_item)
    @id = input_item[:id].to_i
    @name = input_item[:name]
    @description = input_item[:description]
    @unit_price = BigDecimal.new(input_item[:unit_price].to_f,4)
    @created_at = input_item[:created_at] || Time.now
    @updated_at = input_item[:updated_at] || Time.now
    @merchant_id = input_item[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
