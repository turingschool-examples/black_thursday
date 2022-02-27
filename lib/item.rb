require 'bigdecimal'
require 'time'

class Item
  attr_accessor :name, :description, :unit_price, :updated_at
  attr_reader :id, :created_at, :merchant_id

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = BigDecimal(attributes[:unit_price]) / 100
    @created_at = Time.parse(attributes[:created_at].to_s)
    @updated_at = Time.parse(attributes[:updated_at].to_s)
    @merchant_id = attributes[:merchant_id].to_i
  end

  def unit_price_to_dollars
    BigDecimal(@unit_price.to_f.round(2), 4)
  end
end
