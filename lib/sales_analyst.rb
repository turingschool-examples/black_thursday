require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/merchant_repository"

class SalesAnalyst
  attr_reader :items, :merchants
  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def average_items_per_merchant
    items.all.count.to_f / merchants.all.count.to_f
  end
end
