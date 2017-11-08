require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :parent

  def initialize(attributes, parent)
    @id          = attributes[:id].to_i
    @name        = attributes[:name]
    @description = attributes[:description]
    @unit_price  = BigDecimal.new(attributes[:unit_price]) / 100
    @merchant_id = attributes[:merchant_id].to_i
    @created_at  = Time.parse(attributes[:created_at])
    @updated_at  = Time.parse(attributes[:updated_at])
    @parent = parent
  end

  def unit_price_to_dollars
    unit_price * 1.0
  end

  def merchant
    parent.find_merchant_by_id(merchant_id)
  end

end
