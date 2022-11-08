# frozen_string_literal: true

require 'timeable'
require 'calculable'

# This is the item class
class Item
  include Calculable, Timeable
  attr_reader :id,
              :name,
              :merchant_id,
              :description,
              :created_time,
              :updated_time

  def initialize(data, repo)
    @item_repo   = repo
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @created_time  = data[:created_at]
    @updated_time  = data[:updated_at]
    @merchant_id = data[:merchant_id]
    @unit_price  = data[:unit_price]
  end

  def unit_price
    BigDecimal(price_converter(@unit_price))
  end

  def unit_price_to_dollars
    price_converter(@unit_price).to_f
  end

  def update(attributes)
    @name = attributes[:name] unless attributes[:name].nil?
    @description = attributes[:description] unless attributes[:description].nil?
    @unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    @updated_time = Time.now
  end
end
