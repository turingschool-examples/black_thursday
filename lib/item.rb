require 'time'
require 'bigdecimal'

class Item
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def created_at
    Time.now
  end

  def updated_at
    Time.now
  end

  def unit_price
    BigDecimal.new(item.fetch(:unit_price).to_i)/100.0
  end

  def merchant_id
    item.fetch(:merchant_id).to_i
  end

  def id
    item.fetch(:id).to_i
  end

  def name
    item.fetch(:name)
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def description
    item.fetch(:description).downcase
  end

end
