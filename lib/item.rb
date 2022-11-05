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
    @unit_price = BigDecimal(info[:unit_price], 4)
    @unit_price = (@unit_price / 100) if (@unit_price % 1).zero?
    @created_at = Time.parse(info[:created_at].to_s)
    @updated_at = Time.parse(info[:updated_at].to_s)
    @merchant_id = info[:merchant_id].to_i
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def update(attributes)
    @name = attributes[:name] if attributes.key?(:name)
    @description = attributes[:description] if attributes.key?(:description)
    @unit_price = attributes[:unit_price] if attributes.key?(:unit_price)
    @updated_at = Time.now
    self
  end
end
