require 'bigdecimal'
require 'time'

class Item
  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = (BigDecimal(attributes[:unit_price])/100)
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @merchant_id = attributes[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

# talk to instructor about using these helper methods 
  def created_at_to_time
    Time.parse(@created_at)
  end

  def updated_at_to_time
    Time.parse(@updated_at)
  end
end
