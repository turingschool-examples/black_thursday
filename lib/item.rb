# frozen_string_literal: true

# This is the item class
class Item
  attr_reader :id,
              :name,
              :merchant_id,
              :description,
              :created_at,
              :updated_at

  def initialize(data)
    @id          = data[:id]
    @name        = data[:name]
    @description = data[:description]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @merchant_id = data[:merchant_id]
    @unit_price  = data[:unit_price]
  end

  def unit_price
    BigDecimal(@unit_price.to_s, 4)
  end

  def unit_price_to_dollars
    unit_price = @unit_price.to_s
    if unit_price.length > 2 && !unit_price.include?('.')
      unit_price = unit_price.chars.insert(-3, '.').join
    end
    unit_price.to_f
  end

  def update(attributes)
    @name = attributes[:name] unless attributes[:name].nil?
    @description = attributes[:description] unless attributes[:description].nil?
    @unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    @updated_at = Time.now
  end
end
