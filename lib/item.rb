require 'pry'
require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal.new(data[:unit_price])
    @merchant_id = data[:merchant_id]
    @created_at = Time.new(data[:created_at][0], data[:created_at][1], data[:created_at][2], data[:created_at][3], data[:created_at][4], data[:created_at][5]).utc#data[:created_at]
    @updated_at = Time.new(data[:updated_at][0], data[:updated_at][1], data[:updated_at][2], data[:updated_at][3], data[:updated_at][4], data[:updated_at][5]).utc
  end

  def unit_price_to_dollars
    unit_price.to_f/100
  end
end
