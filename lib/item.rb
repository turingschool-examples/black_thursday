require 'bigdecimal'

class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at
  attr_accessor :merchant

  def initialize(item_information)
    @id = item_information[:id].to_i
    @name = item_information[:name]
    @description = item_information[:description]
    @unit_price = unit_price_to_dollars(item_information[:unit_price])
    @merchant_id = item_information[:merchant_id].to_i
    @created_at = Time.parse(item_information[:created_at])
    @updated_at = Time.parse(item_information[:updated_at])
  end

  def unit_price_to_dollars(price)
    BigDecimal.new(price) / 100
  end
end
