require 'bigdecimal'
require 'time'

class Item
  attr_reader :id, 
              :merchant_id, 
              :created_at
  attr_accessor :name, 
                :description, 
                :unit_price, 
                :updated_at

  def initialize(attributes)
    @id           = attributes[:id].to_i
    @name         = attributes[:name]
    @description  = attributes[:description]
    @unit_price   = attributes[:unit_price].to_f / 100
    @created_at   = Time.parse(attributes[:created_at].to_s)
    @updated_at   = Time.parse(attributes[:updated_at].to_s)
    @merchant_id  = attributes[:merchant_id]
  end

  def unit_price
    BigDecimal(@unit_price,4)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end