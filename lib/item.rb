class Item
  #Time.parse(whatever time is in csv) - returns properly formatted time object
  #can call on this when checking created at etc
  # attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id
   def initialize(hash)
    #  (id, name, description, unit_price, created_at, updated_at, merchant_id)
     @id
     @name
     @description
     @unit_price
     @created_at
     @updated_at
     @merchant_id
   end

   def unit_price_per_dollars
   end
end
