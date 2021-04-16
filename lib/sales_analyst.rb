require './lib/sales_engine'

class SalesAnalyst
end

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def average_items_per_merchant
    total_number_items = @items.all.length
    total_number_merchants = @merchants.all.length
    total_number_items / total_number_merchants
  end
end
