require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(info, item_repository = "")
    @id = info[:id]
    @name = info[:name]
    @description = info[:description]
    @unit_price = BigDecimal(info[:unit_price])
    @merchant_id = info[:merchant_id]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
  end


  def unit_price_to_dollars
    (@unit_price/100).to_f
  end
end
