# frozen_string_literal: true

require 'time'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :merchant_id

  def initialize(details)
    @id = details[:id].to_i
    @name = details[:name]
    @description = details[:description]
    @unit_price = BigDecimal(details[:unit_price]) / 100
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
    @name = name unless name.nil?
  end

  def update_description(description)
    @description = description unless description.nil?
  end

  def update_unit_price(unit_price)
    @unit_price = unit_price unless unit_price.nil?
  end

  def update_time
    @updated_at = Time.now
  end

  def created_at
    if @created_at.instance_of?(Time)
      @created_at
    else
      Time.parse(@created_at)
    end
  end

  def updated_at
    if @updated_at.instance_of?(Time)
      @updated_at
    else
      Time.parse(@updated_at)
    end
  end
end
