require 'bigdecimal'
require 'time'

class Item
  attr_reader :id, :merchant_id
  attr_accessor :name, :description, :unit_price

  def initialize(item_info)
    @id           = item_info[:id].to_i
    @name         = item_info[:name]
    @description  = item_info[:description]
    @unit_price   = item_info[:unit_price].to_f
    @created_at   = item_info[:created_at]
    @updated_at   = item_info[:updated_at]
    @merchant_id  = item_info[:merchant_id]
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end