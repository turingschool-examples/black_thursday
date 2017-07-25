require 'csv'
require 'bigdecimal'

class Item
  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :unit_price_to_dollars

  def initialize(item_hash)
    @id = item_hash[:id].to_i
    @name = item_hash[:name]
    @description = item_hash[:description]
    @unit_price = BigDecimal.new(item_hash[:unit_price])
    @created_at = item_hash[:created_at]
    @updated_at = item_hash[:updated_at]
    @unit_price_to_dollars = unit_price.to_f
  end

  def merchant


  end

end
