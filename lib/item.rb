require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :created_at,
              :merchant_id,
              :name,
              :description,
              :unit_price

  attr_accessor :updated_at

  def initialize(item)
    @id = item[:id].to_i
    @name = item[:name]
    @description = item[:description]
    @unit_price = BigDecimal((item[:unit_price].to_f / 100), 4)
    @created_at = return_time_from(item[:created_at])
    @updated_at = return_time_from(item[:updated_at])
    @merchant_id = item[:merchant_id].to_i
  end

  def return_time_from(object)
    return object if object.instance_of?(Time)
    return Time.parse(object) if object.instance_of?(String)
    return nil
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
