
class SalesAnalyst

  def initialize(engine)
    @engine = engine

  end

  def average_items_per_merchant
    @engine.items.all.count.to_f / @engine.merchants.all.count.to_f
  end

  def average_items_per_merchant_standard_deviation
    item_counts = get_item_count_from_merchants
    squared = square_counts(item_counts)
    sum = squared.inject(:+)
    divided = sum / (@engine.merchants.all.count - 1)
    Math.sqrt(divided).round(2)
  end

  def get_item_count_from_merchants
    @engine.merchants.all.map do |merchant|
      merchant.items.count
    end
  end

  def square_counts(item_counts)
    squared = item_counts.map do |count|
      (count - average_items_per_merchant) ** 2
    end
  end

  def merchants_with_high_item_count
    bar = average_items_per_merchant + average_items_per_merchant_standard_deviation
    @engine.merchants.all.find_all do |merchant|
      merchant.items.count > bar
    end
  end


end
