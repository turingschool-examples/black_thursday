require "bigdecimal"
class Item
  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id
  attr_writer :name, :description, :unit_price, :updated_at
  def initialize(stats)
    @id = stats[:id]
    @name = stats[:name]
    @description = stats[:description]
    @unit_price = stats[:unit_price]
    @created_at = stats[:created_at]
    @updated_at = stats[:updated_at]
    @merchant_id = stats[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end


end
