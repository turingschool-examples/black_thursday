require 'bigdecimal'
require 'bigdecimal/util'

class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

  def initialize(item_hash)
    @id = item_hash[:id].to_i
    @name = item_hash[:name]
    @description = item_hash[:description]
    @unit_price = to_big_decimal(item_hash[:unit_price]) unless item_hash[:unit_price] == nil
    @merchant_id = item_hash[:merchant_id]
    @created_at = item_hash[:created_at]
    @updated_at = item_hash[:updated_at]
  end

<<<<<<< HEAD
end
  
=======
  def unit_price_to_dollars
    @unit_price.to_f / 100
  end

  def to_big_decimal(input)
    input = BigDecimal.new(input, input.length)
  end



end
>>>>>>> 63d4d42516816a64ced87fab99df6901ebe79f96
