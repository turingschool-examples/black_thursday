require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent = nil)
    @id =           data[:id].to_i
    @name =         data[:name]
    @description =  data[:description]
    @unit_price =   prep_unit_price(data[:unit_price])
    @merchant_id =  data[:merchant_id].to_i
    @created_at =   prep_time(data[:created_at])
    @updated_at =   prep_time(data[:updated_at])
    @parent     =   parent
  end

  def prep_time(time)
    return nil unless time
    Time.parse(time)
  end

  def prep_unit_price(unit_price)
    return nil unless unit_price
    digits = unit_price.length + 1
    value  = unit_price.to_i / 100.0
    BigDecimal.new(value, digits)
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def merchant
    @parent.find_merchant_by_id(@merchant_id)
  end
end
