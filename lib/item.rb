require 'bigdecimal'

class Item
  attr_reader :id,
              :merchant_id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :parent

  def initialize(attributes, parent = nil)
    @id = attributes[:id].to_i
    @merchant_id = attributes[:merchant_id].to_i
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = BigDecimal.new(attributes[:unit_price])/100
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
    @parent = parent
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def merchant
    parent.parent.merchants.find_by_id(merchant_id)
  end


end
