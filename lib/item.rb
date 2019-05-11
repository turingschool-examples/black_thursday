# frozen_string_literal: true

require 'time'
require 'bigdecimal'

# item
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :item_repository

  def initialize(data, parent)
    @id              = data[:id].to_i
    @name            = data[:name]
    @description     = data[:description]
    @unit_price      = BigDecimal(data[:unit_price]) / 100.0
    @merchant_id     = data[:merchant_id].to_i
    @created_at      = Time.parse(data[:created_at])
    @updated_at      = Time.parse(data[:updated_at])
    @item_repository = parent
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def change_name(name)
    @name = name
  end

  def change_description(description)
    @description = description
  end

  def change_updated_at
    @updated_at = Time.now
  end

  def change_unit_price(unit_price)
    @unit_price = unit_price
  end
end
