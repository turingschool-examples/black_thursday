class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :item_repo

 def initialize(item)
   @id   = item[:id]
   @name = item[:name]
   @description = item[:description]
   @unit_price = item[:unit_price]
   @created_at = item[:created_at]
   @updated_at = item[:updated_at]
   @merchant_id = item[:merchant_id]
   @item_repo = item[:item_repo]
 end

 def unit_price_to_dollars
   "$#{unit_price.to_f}"
 end

 def merchant
   item_repo.se.merchant_repository.merchants.find_all do |merchant|
     merchant_id == merchant.id
   end
 end

end
