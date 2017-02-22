require 'bigdecimal'
class Item
  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at

  def initialize(info = {})
    @id = info[:id]
    @name = info[:name]
    @description = info[:description]
    @unit_price = info[:unit_price]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

end
