require 'bigdecimal'
require './lib/type_conversion'

class Item

  include TypeConversion
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(datum)
    @id = datum[:id]
    @name = datum[:name]
    @description = datum[:description]
    @unit_price = convert_to_big_decimal(datum[:unit_price])
    @merchant_id = datum[:merchant_id]
    @created_at = datum[:created_at]
    @updated_at = datum[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
