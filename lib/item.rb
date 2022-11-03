require 'bigdecimal'
require 'csv'
require_relative './item_repository'
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(info)
    @id = info[:id]
    @name = info[:name].downcase
    @description = info[:description].downcase
    @unit_price = info[:unit_price]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @merchant_id = info[:merchant_id]
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def update(attributes)
    @name = attributes[:name].downcase
    @description = attributes[:description].downcase
    @unit_price = attributes[:unit_price]
    self
  end
end
