require 'csv'
require 'bigdecimal'
require 'pry'
require 'date'
class Item
  attr_reader :id, :name, :description, :unit_price,
              :created_at, :updated_at, :merchant_id, :repository

   def initialize(item_hash, repository)
     @repository = repository
     @id = item_hash[:id].to_i
     @name = item_hash[:name]
     @description = item_hash[:description]
     @unit_price = BigDecimal.new(item_hash[:unit_price]) / 100.00
     @merchant_id = item_hash[:merchant_id].to_i
     @created_at = Time.parse(item_hash[:created_at])
     @updated_at = Time.parse(item_hash[:updated_at])
   end

   def unit_price_per_dollars
     @unit_price.to_f
     # sprintf to convert big floats into dollar amounts
   end

   def merchant
     @repository.find_merchant(@merchant_id)
   end

end
