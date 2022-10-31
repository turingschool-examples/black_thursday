class Item

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @description = hash[:item_description]
    @unit_price = hash[:unit_price]
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
    @merchant_id = hash[:merchant_id]    
  end 
end 