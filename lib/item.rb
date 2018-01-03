require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(data, parent)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal.new(data[:unit_price], 4)
    @created_at = Time.now
    @updated_at = Time.now
    @merchant_id = data[:merchant_id]
  end

  def unit_price_in_dollars
    @unit_price.to_f.round(2)
  end
end
