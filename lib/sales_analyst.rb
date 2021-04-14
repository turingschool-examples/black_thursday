require './lib/sales_engine'

class SalesAnalyst
  attr_reader :merchants,
              :items

  def initialize(merchants, items)
    @merchants = merchants
    @items = items
  end

  def average_items_per_merchant
    @items.all.length.fdiv(@merchants.all.length).round(2)
  end
end
