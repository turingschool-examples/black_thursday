class Item
  attr_reader :id, 
              :name, 
              :description, 
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @description = hash[:description]
    @unit_price = hash[:unit_price]
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
    @merchant_id = hash[:merchant_id]    
  end 

  def unit_price_to_dollars
    @unit_price.to_f.truncate(2)
  end
  
  def update_name(name)
    @name = name
  end
  
  def update_description(description)
    @description = description
  end
  
  def update_unit_price(number,digit)
    @unit_price = BigDecimal(number,digit)
  end
end 
