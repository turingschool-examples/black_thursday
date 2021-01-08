require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(input)
    @input = input
    @id = input[:id].to_i
    @name = input[:name]
    @description = input[:description]
    @unit_price = input[:unit_price]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
    @merchant_id = input[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
