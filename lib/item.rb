class Item
  attr_reader :id, 
              :name, 
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id
  
  def initialize(item_info = nil)
    raise ArgumentError.new(error) unless item_info_clean?(item_info)
    @id          = item_info[:id]
    @name        = item_info[:name]
    @description = item_info[:description]
    @unit_price  = item_info[:unit_price]
    @created_at  = item_info[:created_at]
    @updated_at  = item_info[:updated_at]
    @merchant_id = item_info[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def item_info_clean?(item_info)
    item_info.to_h.any?                      && 
    item_info[:id].is_a?(Integer)            &&
    item_info[:name].is_a?(String)           &&
    item_info[:description].is_a?(String)    &&
    item_info[:unit_price].is_a?(BigDecimal) &&    
    item_info[:created_at].is_a?(Time)       &&    
    item_info[:updated_at].is_a?(Time)       &&
    item_info[:merchant_id].is_a?(Integer)   
  end

  def error
    %{
      Error:
      :id and :merchant_id must be an Integer 
      :name and :description must be a String, 
      :unit_price must be a BigDecimal
      :created_at and :updated_at must be a Time.
      }
  end

end