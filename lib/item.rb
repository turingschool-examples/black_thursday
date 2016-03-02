class Item
  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id

   def initialize(item_hash)
     @id = item_hash[:id]
     @name = item_hash[:name]
     @description = item_hash[:description]
    #  @unit_price = BigDecimal.new(item_hash[:unit_price]) => returns object instead of value
     @merchant_id = item_hash[:merchant_id]
     @created_at = Time.now, # (item_hash[:created_at]) => doesn't take argument
     @updated_at = Time.now, # (item_hash[:updated_at]) => doesn't take argument
   end

   def unit_price_per_dollars
   end
end
