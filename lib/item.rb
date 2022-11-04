require 'bigdecimal'
require 'csv'
require 'time'
require 'pry'
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
    @id = info[:id].to_i
    @name = info[:name]
    @description = info[:description]
    @unit_price = BigDecimal(info[:unit_price], 4) / 100
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
    @merchant_id = info[:merchant_id]
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def update(attributes)
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = attributes[:unit_price]
    self
  end
end
