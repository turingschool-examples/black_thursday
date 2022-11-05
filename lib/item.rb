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
    @unit_price = to_price(info[:unit_price])
    @created_at = to_time(info[:created_at])
    @updated_at = to_time(info[:updated_at])
    @merchant_id = info[:merchant_id].to_i
  end

  def to_price(price)
    p = BigDecimal(price, 4)
    (p / 100) if (p % 1).zero?
  end

  def to_time(time)
    Time.parse(time.to_s)
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def update(attributes)
    @name = attributes[:name] if attributes[:name]
    @description = attributes[:description] if attributes[:description]
    @unit_price = attributes[:unit_price] if attributes[:unit_price]
    @updated_at = Time.now
    self
  end
end
