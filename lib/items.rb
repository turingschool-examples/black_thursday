require 'bigdecimal'

class Item
  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id,
                :unit_price_to_dollars

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = (BigDecimal(attributes[:unit_price])/100)
    @created_at = attributes[:created_at]
    @updated_at = attributes[:created_at]
    @merchant_id = attributes[:merchant_id].to_i
  end
end
