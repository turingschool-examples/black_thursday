require 'bigdecimal'
require 'date'
class Item
  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id, :engine

  def initialize(info = {}, item_repository = "")
    @id = info[:id].to_i
    @name = info[:name]
    @description = info[:description]
    @unit_price = BigDecimal.new(info[:unit_price].to_f/100, 4)
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @merchant_id = info[:merchant_id].to_i
    @engine = engine
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end
end
