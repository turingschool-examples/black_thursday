require 'bigdecimal'
require 'bigdecimal/util'
require 'time'

class Item
  attr_reader   :id,
                :merchant_id,
                :created_at
  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(information)
    @id = information[:id].to_i
    @name = information[:name]
    @description = information[:description]
    @unit_price = BigDecimal.new(information[:unit_price].to_f / 100, 4)
    @merchant_id = information[:merchant_id].to_i
    @created_at = Time.parse(information[:created_at].to_s)
    @updated_at = Time.parse(information[:updated_at].to_s)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
