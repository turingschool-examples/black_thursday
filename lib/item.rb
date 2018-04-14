# Frozen_string_literal: true

require 'bigdecimal'
require 'time'

# Item
class Item
  attr_reader   :id,
                :unit_price_to_dollars,
                :created_at,
                :updated_at,
                :merchant_id,
                :parent

  attr_accessor :name,
                :description,
                :unit_price

  def initialize(item, parent)
    @id = item[:id].to_i
    @name = item[:name]
    @description = item[:description]
    @unit_price = BigDecimal(item[:unit_price])/100
    @unit_price_to_dollars = @unit_price.to_f
    @created_at = Time.parse(item[:created_at].to_s)
    @updated_at = Time.parse(item[:updated_at].to_s)
    @merchant_id = item[:merchant_id].to_i
    @parent = parent
  end
end
