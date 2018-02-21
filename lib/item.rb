# frozen_string_literal: true

require 'time'

# Defines an item in the store
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :item_repository

  def initialize(data, item_repository)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = price_to_big_decimal data[:unit_price]
    @created_at = Time.parse data[:created_at]
    @updated_at = Time.parse data[:updated_at]
    @merchant_id = data[:merchant_id].to_i
    @item_repository = item_repository
  end

  def price_to_big_decimal(price)
    BigDecimal.new(price.to_i) / 100.0
  end
end
