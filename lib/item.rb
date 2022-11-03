# frozen_string_literal: true

# This is the item class
class Item
  def initialize(stats)
    @stats = stats
  end

  def id
    @stats[:id]
  end

  def name
    @stats[:name]
  end

  def description
    @stats[:description]
  end

  def unit_price
    unit_price = @stats[:unit_price].to_s
    if unit_price.length > 2 && !unit_price.include?('.')
      return BigDecimal(unit_price.chars.insert(-3, '.').join, 4)
    end
    BigDecimal(unit_price, 4)
  end

  def created_at
    @stats[:created_at]
  end

  def updated_at
    @stats[:updated_at]
  end

  def merchant_id
    @stats[:merchant_id]
  end

  def unit_price_to_dollars
    unit_price.round(2, :ceil).to_f
  end

  def update(attributes)
    @stats[:name] = attributes[:name] unless attributes[:name].nil?
    @stats[:description] = attributes[:description] unless attributes[:description].nil?
    @stats[:unit_price] = attributes[:unit_price] unless attributes[:unit_price].nil?
    @stats[:updated_at] = Time.now
  end
end
