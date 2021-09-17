require 'bigdecimal'
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
    @id           = info[:id].to_i
    @name         = info[:name]
    @description  = info[:description].upcase
    @unit_price   = BigDecimal.new(info[:unit_price], 4) / 100
    @created_at   = Time.parse(info[:created_at])
    @updated_at   = Time.parse(info[:updated_at])
    @merchant_id  = info[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def change_name(new_name)
    @name = new_name
    @updated_at = Time.now.utc
  end

  def change_description(new_description)
    @description = new_description
    @updated_at = Time.now.utc
  end

  def change_unit_price(new_price)
    @unit_price = new_price
    @updated_at = Time.now.utc
  end
end
