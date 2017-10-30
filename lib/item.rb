require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(attributes)
    @id          = attributes[:id]
    @name        = attributes[:name]
    @description = attributes[:description]
    @unit_price  = BigDecimal.new(attributes[:unit_price])
    @merchant_id = attributes[:merchant_id]
    @created_at  = attributes[:created_at]
    @updated_at  = attributes[:updated_at]
  end

  def unit_price_to_dollars
    unit_price / 100.00
  end

end
