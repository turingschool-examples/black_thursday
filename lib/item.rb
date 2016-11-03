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
              :parent

  def initialize(data, parent = nil)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal(data[:unit_price])/100
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @merchant_id = data[:merchant_id].to_i
    @parent = parent
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def merchant
    parent.find_merchant(merchant_id)
  end

end