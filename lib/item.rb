require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id
  def initialize(item_info)
    @id = item_info[:id]
    @name = item_info[:name]
    @description = item_info[:description]
    @unit_price = BigDecimal.new(item_info[:unit_price], item_info[:unit_price].length)
    @created_at = item_info[:created_at]
    @updated_at = item_info[:updated_at]
    @merchant_id = item_info[:merchant_id]
  end
end
