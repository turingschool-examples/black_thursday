require 'bigdecimal'

class Item
  attr_reader :id, :created_at, :merchant_id
  attr_accessor :name, :description, :unit_price, :updated_at

  def initialize(items_hash)
    @id = items_hash[:id].to_i
    @name = items_hash[:name]
    @description = items_hash[:description]
    @unit_price = BigDecimal.new(items_hash[:unit_price].to_i)/100
    @created_at = items_hash[:created_at]
    @updated_at = items_hash[:updated_at]
    @merchant_id = items_hash[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end
end
