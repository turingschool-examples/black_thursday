require 'bigdecimal'

class Item
  attr_accessor     :id,
                    :merchant_id,
                    :name,
                    :description,
                    :unit_price,
                    :created_at,
                    :updated_at,
                    :unit_price_to_dollars,
                    :merchant_id

  def initialize(item_attributes)
    @id = item_attributes[:id].to_i
    @merchant_id = item_attributes[:merchant_id].to_i
    @name = item_attributes[:name]
    @description = item_attributes[:description]
    @unit_price = BigDecimal.new(item_attributes[:unit_price] / 100)
    @created_at = Time.new
    @updated_at = Time.new
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
