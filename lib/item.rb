require "bigdecimal"
require "time"
require 'pry'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :parent
  def initialize(attributes, parent)
              @id          = attributes[:id].to_i
              @name        = attributes[:name]
              @description = attributes[:description]
              @unit_price  = BigDecimal.new(attributes[:unit_price])/100
              @created_at  = Time.parse(attributes[:created_at])
              @updated_at  = Time.parse(attributes[:updated_at])
              @merchant_id = attributes[:merchant_id].to_i
              @parent      = parent
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
