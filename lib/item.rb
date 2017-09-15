require 'bigdecimal'
require 'time'

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
    @created_at  = Time.parse(info[:created_at].to_s)
    @updated_at  = Time.parse(info[:updated_at].to_s)
    @merchant_id = info[:merchant_id].to_i
    @parent      = parent
  end

  def merchant
    @parent.find_merchant_that_owns_item(@merchant_id)
  end
end
