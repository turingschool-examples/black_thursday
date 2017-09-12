require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(info, parent=nil)
    @id          = info[:id].to_i
    @name        = info[:name]
    @description = info[:description]
    @unit_price  = BigDecimal.new(info[:unit_price].to_i/100.0, 4)
    @created_at  = info[:created_at]
    @updated_at  = info[:updated_at]
    @merchant_id = info[:merchant_id]
    @parent      = parent
  end

  def merchant 
    @parent.find_merchant_that_owns_item(@merchant_id)
  end
end
