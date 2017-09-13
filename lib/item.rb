require 'time'
require 'bigdecimal'

class Item
  attr_reader :item
  def initialize(item)
    @item = item
  end

  def id
    item.fetch(:id).to_i
  end

  def name
    item.fetch(:name)
  end

  def description
    item.fetch(:description)
  end

  def unit_price
    BigDecimal.new(item.fetch(:unit_price))
  end

  def created_at
    Time.parse(item.fetch(:created_at))
  end

  def updated_at
    Time.parse(item.fetch(:updated_at))
  end

  def merchant_id
    item.fetch(:merchant_id).to_i
  end

  def unit_to_dollar
    price = unit_price.to_f.to_s
    "$#{price}"
  end
end
