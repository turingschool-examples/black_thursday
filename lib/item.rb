require 'bigdecimal'
require 'time'
require 'pry'

class Item

  attr_reader :name, :id, :description, :unit_price, :created_at, :updated_at, :merchant_id

  def initialize(item)
    @name = item[:name]
    @id = item[:id].to_i
    @description = item[:description]
    @unit_price = unit_price_to_dollars(item[:unit_price])
    @created_at = Time.parse(item[:created_at])
    @updated_at = Time.parse(item[:updated_at])
  end

  def unit_price_to_dollars(price)
    BigDecimal.new(price) / 100
    # returns the price of the item in dollars formatted as a Float
  end

end
