# frozen_string_literal: true

# :nodoc:
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id
  def initialize(item)
    @id          = item[:id]
    @name        = item[:name]
    @description = item[:description]
    @unit_price  = (BigDecimal(item[:unit_price], 4) / 100)
    @created_at  = item[:created_at]
    @updated_at  = item[:updated_at]
    @merchant_id = item[:merchant_id]
  end

  def price_to_dollars
    unit_price.to_f
  end
end
