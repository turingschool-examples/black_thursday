require './lib/sales_engine'

class SalesAnalyst
  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def average_items_per_merchant
    (@items.count.to_f / @merchants.count).round(2)
  end
end
