

class Item
  attr_reader :name, 
              :id, 
              :description, 
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at
  
  def initialize(item_details)
    @id          = item_details[:id]
    @name        = item_details[:name]
    @description = item_details[:description]
    @unit_price  = item_details[:unit_price]
    @merchant_id = item_details[:merchant_id]
    @created_at  = item_details[:created_at]
    @updated_at  = item_details[:updated_at]
  end
end