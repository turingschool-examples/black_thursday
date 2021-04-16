# frozen_string_literal: true
require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(details)
    @id = details[:id].to_i
    @name = details[:name]
    @description = details[:description]
    @unit_price = details[:unit_price]
    @created_at = details[:created_at]
    @updated_at = details[:updated_at]
    @merchant_id = details[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update_id(id)
    @id = id
  end

  def update_name(name)
    @name = name
  end

  def update_description(description)
    @description = description
  end

  def update_unit_price(unit_price)
    @unit_price = unit_price
  end

  def update_time
    @updated_at = Time.now
  end
end
