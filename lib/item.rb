require 'bigdecimal'
require 'time'
class Item
  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :updated_at
  attr_reader :created_at,
              :merchant_id
  def initialize(item_info)
    @id = item_info[:id].to_i
    @name = item_info[:name].to_s
    @description = item_info[:description].to_s
    @unit_price = big_decimal_converter(item_info[:unit_price])
    @created_at = Time.parse(item_info[:created_at])
    @updated_at = Time.parse(item_info[:updated_at])
    @merchant_id = item_info[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def big_decimal_converter(price)
    significant_digits = price.to_s.length
    number = price.to_f / 100
    BigDecimal.new(number, significant_digits)
  end
end
