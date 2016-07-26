require 'bigdecimal'

class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(datum)
    @id = datum[:id]
    @name = datum[:name]
    @description = datum[:description]
    @unit_price = convert_to_big_decimal(datum[:unit_price])
    @merchant_id = datum[:merchant_id]
    @created_at = datum[:created_at]
    @updated_at = datum[:updated_at]
  end

  def convert_to_big_decimal(unit_price)
    if unit_price.is_a?(String)
      BigDecimal.new(unit_price.to_f/100, 4)
    elsif unit_price.is_a?(BigDecimal)
      unit_price
    end
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
