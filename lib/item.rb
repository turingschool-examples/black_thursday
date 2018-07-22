require 'bigdecimal'
require 'bigdecimal/util'

class Item
  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :updated_at,
                :created_at

  attr_reader :merchant_id

  def initialize(attributes)
    @id          = attributes[:id]
    @name        = attributes[:name]
    @description = attributes[:description]
    @unit_price  = attributes[:unit_price].to_d
    @created_at  = attributes[:created_at]
    @updated_at  = attributes[:updated_at]
    @merchant_id = attributes[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f/100
  end

  # def convert_to_big_decimal
  #   float_price = @unit_price.to_f/100
  #   # price_as_integer = @unit_price.to_i
  #   @unit_price = BigDecimal(float_price, @unit_price.length)
  # end
end
