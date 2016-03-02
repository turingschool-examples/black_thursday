require 'pry'
class Item
  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id

   def initialize(item_hash)
     @id = item_hash[:id]
     @name = item_hash[:name]
     @description = item_hash[:description]
     @unit_price = BigDecimal.new(item_hash[:unit_price])
     # unit_price return 12.00 and has class BigDecimal on spec
     @merchant_id = item_hash[:merchant_id]
     @created_at = Time.parse(item_hash[:created_at])
     @updated_at = Time.parse(item_hash[:updated_at])
     # do we need to change format of data to work with Time class
   end

   def unit_price_per_dollars
     @unit_price.to_f/100
   end

end
