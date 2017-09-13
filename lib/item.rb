require 'bigdecimal'
class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(information)
    @id = information[:id]
    @name = information[:name]
    @description = information[:description]
    @unit_price = BigDecimal.new(information[:unit_price])
    @created_at = information[:created_at]
    @updated_at = information[:updated_at]
    @merchant_id = information[:merchant_id]
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

end
