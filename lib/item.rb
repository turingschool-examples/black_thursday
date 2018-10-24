require "bigdecimal"
require 'time'
class Item
  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id
  attr_writer :name, :description, :unit_price, :updated_at
  def initialize(stats)
    @id = stats[:id].to_i
    @name = stats[:name]
    @description = stats[:description]
    @unit_price = get_unit_price(stats[:unit_price])
    @created_at = Time.parse(stats[:created_at])
    @updated_at = Time.parse(stats[:updated_at])
    @merchant_id = stats[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def get_unit_price(price)
    figures = price.to_s.length
    price = price.to_f / 100
    BigDecimal.new(price, figures)
  end


end
