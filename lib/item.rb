require 'time'
require 'bigdecimal'

class Item
  attr_reader :item

  def initialize(item)
    @item =item
  end

  def created_at
    Time.now
  end

  def updated_at
    Time.now
  end

  def unit_price
    BigDecimal.new(item.fetch(:unit_price).to_i)
  end
end
