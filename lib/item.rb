require 'pry'
require "bigdecimal" 

class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at
  
  def initialize(data)
    @id  = data[:id]
    @name = data[:name]
    @description = data[:description]
# binding.pry
    @unit_price =  data[:unit_price]
    @merchant_id = data[:merchant_id]
    @created_at  = Time.now
    @updated_at = Time.now
    # binding.pry
  end


end
