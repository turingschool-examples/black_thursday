require 'bigdecimal'
require 'time'

class Item
  attr_reader :name,
              :id,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(hash, ir)
    @ir          = ir
    @id          = hash[:id].to_i
    @name        = hash[:name]
    @description = hash[:description]
    @unit_price  = BigDecimal.new(hash[:unit_price], 4) /100
    @created_at  = Time.parse(hash[:created_at])
    @updated_at  = Time.parse(hash[:updated_at])
    @merchant_id = hash[:merchant_id].to_i
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def merchant
    @ir.merchant(self.merchant_id)
  end
end
