require 'bigdecimal'

class Merchant
  attr_reader :id,
              :name

  def initialize(data, parent)
    @id = data[:id]
    @name = data[:name]
    @merchant_repository = parent
  end

  def items
    @merchant_repository.find_items_by_id(@id)
  end

  def item_count
    return items.count
  end

  def average_item_price
    sum = items.reduce(0) do |total, item|
      total + item.unit_price
    end
    BigDecimal.new((sum / item_count).to_s)
  end

end
