require 'pry'
require 'money'
require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(item_hash)
    @id           = item_hash[:id]
    @name         = item_hash[:name]
    @description  = item_hash[:description]
    @unit_price   = find_unit_price(item_hash[:unit_price])
    @merchant_id  = item_hash[:merchant_id]
    @created_at   = item_hash[:created_at]
    @updated_at   = item_hash[:updated_at]
  end

  def find_unit_price(price)
    unit_price = BigDecimal.new(price)
    unit_price_to_dollars(unit_price)
  end

  def unit_price_to_dollars(unit_price)
    dollar_price = unit_price.to_f / 100
    binding.pry
  end
end
