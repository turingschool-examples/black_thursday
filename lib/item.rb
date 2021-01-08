require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(info)
    @id = info[:id].to_i
    @name = info[:name]
    @description = info[:description]

    #### fix this haha
    @unit_price = BigDecimal(info[:unit_price])
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
    @merchant_id = info[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
