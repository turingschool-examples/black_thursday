require 'bigdecimal'
require 'time'
class Item
  attr_reader   :id,
                :merchant_id,
                :merchant,
                :created_at

  attr_accessor :unit_price,
                :name,
                :description,
                :updated_at

  def initialize(data)
    @id           = data[:id].to_i
    @name         = data[:name]
    @description  = data[:description]
    @unit_price   = BigDecimal((data[:unit_price].to_i)) / 100
    @merchant_id  = data[:merchant_id].to_i
    @created_at   = Time.parse(data[:created_at])
    @updated_at   = Time.parse(data[:updated_at])
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
