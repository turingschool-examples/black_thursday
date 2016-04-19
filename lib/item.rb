require 'bigdecimal'
require 'time'

class Item

  attr_reader :id, :name, :description, :unit_price,
              :sales_engine, :merchant_id

  def initialize(data, sales_engine)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal.new(data[:unit_price].to_i/100)
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @merchant_id = data[:merchant_id].to_i
    @sales_engine = sales_engine
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def unit_price_to_dollars
    #spec says retun price in dollars - we haven't done that
    @unit_price.to_f
  end

end
