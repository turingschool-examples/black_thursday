require 'bigdecimal'
class Item
  attr_reader :id,
              :merchant_id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(attributes, parent)
    @id = attributes[:id].to_i
    @merchant_id = attributes[:merchant_id].to_i
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = attributes[:unit_price].to_f
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @parent = parent
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

end
