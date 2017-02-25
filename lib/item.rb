require 'pry'
require "bigdecimal" 
require "date"

class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at, :parent
  
  def initialize(data, parent=nil)
    @id  = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price =  data[:unit_price]
    @merchant_id = data[:merchant_id]
    @created_at  = data[:created_at]
    @updated_at = data[:updated_at]
    @parent = parent
    #  binding.pry
  end

# unit_price_to_dollars - returns the price of the item in dollars formatted as a Float
  def unit_price_to_dollars
    unit_price.to_f
  end


  def merchant
    parent.parent.merchants.find_by_id(merchant_id)
  end

end
