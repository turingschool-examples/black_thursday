# frozen_string_literal: true

# This is the item class
class Item
  def initialize(stats, repo)
    @stats = stats
    @item_repo = repo
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
    BigDecimal(@stats[:unit_price], 4)
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
    unit_price.round(2, :half_up).to_f
  end

  def update(attributes)
    @stats[:name] = attributes[:name] unless attributes[:name].nil?
    @stats[:description] = attributes[:description] unless attributes[:description].nil?
    @stats[:unit_price] = attributes[:unit_price] unless attributes[:unit_price].nil?
    @stats[:updated_at] = Time.now
  end
end
