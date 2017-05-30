require "bigdecimal"

class Item 
  attr_reader :name, :description, :unit_price, :created_at, :updated_at
  
  def initialize(attributes)
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = attributes[:unit_price]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end 
  
  def unit_price_to_dollars
    dollar_price = @unit_price.to_f
  end 
end 