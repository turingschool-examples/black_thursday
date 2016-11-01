require 'pry'
require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(item_hash)
    @id           = item_hash[:id].to_i
    @name         = item_hash[:name]
    @description  = item_hash[:description]
    @unit_price   = find_unit_price(item_hash[:unit_price])
    @merchant_id  = item_hash[:merchant_id].to_i
    @created_at   = determine_the_time(item_hash[:created_at])
    @updated_at   = determine_the_time(item_hash[:updated_at])
  end

  def find_unit_price(price)
    if unit_price = ""
      unit_price = BigDecimal.new(0)
      # binding.pry
    else
      unit_price = BigDecimal.new(price)
    end
    return unit_price
    unit_price_to_dollars(unit_price)
  end

  def unit_price_to_dollars(unit_price)
    dollar_price = unit_price.to_f / 100
  end

  def determine_the_time(time_string)
    return Time.now if time_string.nil?
    time_string = Time.parse(time_string)
  end
end
