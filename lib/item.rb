require 'time'
require 'bigdecimal'

class Item
  attr_reader :item

  def initialize(item)

    @item =item

    # @name = item_info[:name]
    # @description = item_info[:description]
    # @unit_price = item_info[:unit_price]
    # @created_at = item_info[:created_at]
    # @updated_at = item_info[:updated_at]
  end

  def created_at
    Time.now
  end

  def updated_at
    Time.now
  end

  def unit_price
    BigDecimal.new(item)
  end
end
