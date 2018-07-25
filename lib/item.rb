require 'bigdecimal'
require 'time'

class Item
  attr_reader :id, :created_at, :merchant_id
  attr_accessor :name, :description, :unit_price, :updated_at

  def initialize(item_data)
    @id = item_data[:id].to_i
    @name = item_data[:name]
    @description = item_data[:description]
    @unit_price = BigDecimal(item_data[:unit_price])
    @created_at = Time.parse(item_data[:created_at].to_s)
    @updated_at = Time.parse(item_data[:updated_at].to_s)
    @merchant_id = item_data[:merchant_id].to_i
  end

  def unit_price_to_dollars
    unit_price.to_f / 100
  end
end
