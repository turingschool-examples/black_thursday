require 'bigdecimal'
require 'time'

class Item
  attr_reader :id, :merchant_id, :created_at
  attr_accessor :name, :description, :unit_price, :updated_at

  def initialize(item_info)
    @id           = item_info[:id].to_i
    @name         = item_info[:name]
    @description  = item_info[:description]
    @unit_price   = item_info[:unit_price].to_f / 100
    @created_at   = Time.parse(item_info[:created_at].to_s)
    @updated_at   = Time.parse(item_info[:updated_at].to_s)
    @merchant_id  = item_info[:merchant_id]
  end

  def unit_price
    BigDecimal(@unit_price,4)
  end

  

  def unit_price_to_dollars
    @unit_price.to_f
  end
end