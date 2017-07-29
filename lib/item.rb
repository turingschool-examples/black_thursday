require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :ir

  def initialize(id, name, description, unit_price,
                created_at, updated_at, merchant_id, ir)
    @id = id
    @name = name
    @description = description
    @unit_price = BigDecimal.new(unit_price.insert(-3, "."))
    @created_at = Time.parse(created_at)
    @updated_at = Time.parse(updated_at)
    @merchant_id = merchant_id
    @ir = ir
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def merchant
    ir.fetch_items_merchant_id(merchant_id)
  end

end