require 'bigdecimal'
require 'time'
class Item
  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :updated_at
  attr_reader :created_at,
              :merchant_id
  def initialize(item_info)
    @id          = item_info[:id].to_i
    @name        = item_info[:name].to_s
    @description = item_info[:description].to_s
    @unit_price  = item_info[:unit_price]
    @created_at  = Time.parse(item_info[:created_at])
    @updated_at  = Time.parse(item_info[:updated_at])
    @merchant_id = item_info[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
