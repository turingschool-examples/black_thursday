require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id
  def initialize(details)
    @id = details[:id]
    @name = details[:name]
    @description = details[:description]
    @unit_price = BigDecimal(details[:unit_price],4)
    @created_at = details[:created_at]
    @updated_at = details[:updated_at]
    @merchant_id = details[:merchant_id]
  end

  def unit_price_to_dollars
    (@unit_price).round(2).to_f
  end
end
