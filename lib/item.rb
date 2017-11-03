require 'time'
require 'bigdecimal'

class Item
  attr_reader :item, :id, :name, :description, :merchant_id,
              :unit_price, :created_at, :updated_at

  def initialize(item)
    @created_at = Time.parse(item[:created_at])
    @updated_at = Time.parse(item[:updated_at])
    @unit_price = BigDecimal.new(item[:unit_price].to_i)
    @merchant_id = item[:merchant_id].to_i
    @id = item[:id].to_i
    @name = item[:name]
    @description = item[:description]
  end

  def unit_price
    @unit_price / 100.0
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

end
