require "bigdecimal"
require "pry"

class Item
  attr_reader :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(data)
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal.new(data[:unit_price], 4)
    @created_at = Time.new(data[:created_at])
    @updated_at = Time.new(data[:updated_at])
    @merchant_id = data[:merchant_id].to_i
  end

  def unit_price_to_dollars
    (unit_price)/100.0
  end
end
