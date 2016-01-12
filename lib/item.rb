require 'bigdecimal'
class Item
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def name
    item[:name]
  end

  def id
    item[:id]
  end

  def merchant_id
    item[:merchant_id]
  end

  def created_at
    item[:created_at]
  end

  def updated_at
    item[:updated_at]
  end

  def description
    item[:description]
  end

  def unit_price
    unit_price = item[:unit_price]
    BigDecimal.new(unit_price.insert(-3, "."))
  end
end
