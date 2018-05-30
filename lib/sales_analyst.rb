class SalesAnalyst
  attr_reader :items,
              :merchants

  def initialize(items, merchants)
    @items     = items
    @merchants = merchants
  end

  def average_items_per_merchant
    (@items.all.length.to_f/@merchants.all.length).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    items      = @items.find_all_by_merchant_id(merchant_id)
    sum_prices = items.reduce(0) do |sum, item|
      sum += item.unit_price
    end
     return sum_prices/items.length
  end

  def average_average_price_per_merchant
    sum_avgs = @merchants.all.reduce(0) do |sum, merchant|
      sum += average_item_price_for_merchant(merchant.id)
    end
    return sum_avgs
  end
end
