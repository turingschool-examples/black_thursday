# frozen_string_literal: true

require 'time'
require 'bigdecimal'

# This is an Item Class
class Item
  attr_reader :id,
              :merchant_id,
              :created_at
  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at
  def initialize(data)
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = BigDecimal(data[:unit_price]) / 100.0
    @merchant_id = data[:merchant_id].to_i
    @created_at  = Time.parse(data[:created_at])
    @updated_at  = Time.parse(data[:updated_at])
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
