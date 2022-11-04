# frozen_string_literal: true

require 'time'
require 'calculable'

# This is the item class
class Item
  include Calculable
  attr_reader :id,
              :name,
              :merchant_id,
              :description

  def initialize(data, repo)
    @item_repo   = repo
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @merchant_id = data[:merchant_id]
    @unit_price  = data[:unit_price]
  end

  def unit_price
    BigDecimal(price_converter(@unit_price))
  end

  def created_at
    return Time.parse(@created_at) if @created_at.is_a? String

    @created_at
  end

  def updated_at
    return Time.parse(@updated_at) if @updated_at.is_a? String

    @updated_at
  end

  def unit_price_to_dollars
    price_converter(@unit_price).to_f
  end

  def update(attributes)
    @name = attributes[:name] unless attributes[:name].nil?
    @description = attributes[:description] unless attributes[:description].nil?
    @unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    @updated_at = Time.now
  end
end
