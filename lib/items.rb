require 'bigdecimal/util'
# frozen_string_literal: true
require 'time'

class Item
  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at
  attr_reader   :id,
                :merchant_id,
                :created_at

  def initialize(items)
    @id = items[:id].to_i
    @name = items[:name]
    @description = items[:description]
    @unit_price = (items[:unit_price].to_d) / 100
    @merchant_id = items[:merchant_id].to_i
    @created_at = Time.parse(items[:created_at])
    @updated_at = Time.parse(items[:updated_at])
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end
end