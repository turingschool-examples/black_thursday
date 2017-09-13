require 'bigdecimal'
require 'time'
require 'pry'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :price

  def initialize(item)
    @id = item[:id]
    @name = item[:name]
    @description = item[:description]
    @price = BigDecimal.new(item[:unit_price])
    @unit_price = unit_price_to_dollars(@price)
    @merchant_id = item[:merchant_id]
    @created_at = Time.parse(item[:created_at].to_s)
    @updated_at = Time.parse(item[:updated_at].to_s)
  end

  def unit_price_to_dollars(unit_price)
    unit_price / 100
  end

end
