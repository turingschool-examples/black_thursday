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
              :updated_at,
              :parent

  def initialize(item_hash, item_repository_instance = nil)
    @id           = item_hash[:id].to_i
    @name         = item_hash[:name]
    @description  = item_hash[:description]
    @unit_price   = find_unit_price(item_hash[:unit_price])
    @merchant_id  = item_hash[:merchant_id].to_i
    @created_at   = determine_the_time(item_hash[:created_at])
    @updated_at   = determine_the_time(item_hash[:updated_at])
    @parent       = item_repository_instance
  end

  def find_unit_price(price)
    if unit_price == ""
      unit_price = BigDecimal.new(0)
    else
      unit_price = BigDecimal.new(price) / 100
    end
    return unit_price
  end

  def unit_price_to_dollars(unit_price)
    @unit_price.to_f
  end

  def determine_the_time(time_string)
    time = Time.new(0)
    return time if time_string == ""
    time_string = Time.parse(time_string)
  end

  def merchant
    @parent.find_all_by_merchant_id(@id)
  end
end
