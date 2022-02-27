require_relative 'sales_engine'
require_relative 'item_repository'

class SalesAnalyst
  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def average_items_per_merchant
    (@items.count.to_f / @merchants.count).round(2)
  end

  def total_items_per_merchant
    items_per_merchant = {}
    @items.map do |item|
      items_per_merchant[item.merchant_id] = 0 if !items_per_merchant.has_key?(item.merchant_id)
      items_per_merchant[item.merchant_id] += 1
    end
    items_per_merchant.values
  end

  def average_items_per_merchant_standard_deviation
    total_items_per_merchant
    total_square_diff = 0
    total_items_per_merchant.map do |item_count|
      total_square_diff += ((item_count - average_items_per_merchant) ** 2)
    end
    Math.sqrt(total_square_diff / (@merchants.count - 1)).round(2)
  end
end
