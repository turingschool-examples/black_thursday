class Item
  attr_reader :name, 
              :description,
              :unit_price,
              :created_at,
              :updated_at
  
  def initialize(item_info = nil)
    raise ArgumentError.new(error) unless item_info_clean?(item_info)
    @name        = item_info[:name]
    @description = item_info[:description]
    @unit_price  = item_info[:unit_price]
    @created_at  = item_info[:created_at]
    @updated_at  = item_info[:updated_at]
  end

  def item_info_clean?(item_info)
    item_info                                && 
    item_info[:name]                         &&
    item_info[:description]                  &&
    item_info[:unit_price]                   &&
    item_info[:created_at]                   &&
    item_info[:updated_at]                   &&
    item_info[:name].is_a?(String)           &&
    item_info[:description].is_a?(String)    &&
    item_info[:unit_price].is_a?(BigDecimal) &&    
    item_info[:created_at].is_a?(Time)       &&    
    item_info[:updated_at].is_a?(Time)    
  end

  def error
    %{
      Error: 
      :name and :description must be a String, 
      :unit_price must be a BigDecimal
      :created_at and :updated_at must be a Time.
      }
  end

end