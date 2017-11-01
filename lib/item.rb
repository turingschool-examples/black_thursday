require 'bigdecimal'

class Item
  attr_reader   :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id,
                :unit_price_to_dollars,
                :parent

  def initialize(attributes = {}, parent = nil)
    @id           = attributes[:id].to_i
    @name         = attributes[:name]
    @description  = attributes[:description]
    @unit_price   = BigDecimal.new(attributes[:unit_price])/100
    @created_at   = attributes[:created_at]
    @updated_at   = attributes[:updated_at]
    @merchant_id  = attributes[:merchant_id]
    @parent = parent
  end

  def unit_price_to_dollars
    unit_price / 100
    # BigDecimal.new(@unit_price).to_f
  end


end
