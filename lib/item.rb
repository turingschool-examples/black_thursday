require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(item)
    @id = item[:id]
    @name = item[:name]
    @description = item[:description]
    @unit_price = item[:unit_price]
    @created_at = item[:created_at]
    @updated_at = item[:updated_at]
    @merchant_id = item[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.round(2).to_f
  end

  def update(attributes)
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = attributes[:unit_price]
  end
end