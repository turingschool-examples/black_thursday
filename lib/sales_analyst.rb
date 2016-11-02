class SalesAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def find_items_by_merchant_id(id)
    sales_engine.items.find_all_by_merchant_id(id)
  end

  def average_items_per_merchant
    items = sales_engine.items.all.count.to_f
    merchants = sales_engine.merchants.all.count.to_f
    (items / merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(std_dev_numerator / std_dev_denominator).round(2)
  end

  def std_dev_numerator
    sales_engine.merchants.all.map do |merchant|
      distance_from_mean_squared(merchant.items.count)
    end.reduce(:+).to_f
  end

  def distance_from_mean_squared(item_count)
    ((item_count - average_items_per_merchant) ** 2).to_f
  end

  def std_dev_denominator
    (sales_engine.merchants.all.count - 1).to_f
  end

  def average_item_price_per_merchant(id)
    items = find_items_by_merchant_id(id)
    (items.map {|row|  row.unit_price}).reduce(:+) / items.count
  end

  def merchants_with_high_item_count
    avg     = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    sales_engine.merchants.all.find_all do |merchant|
      merchant.items.count > avg + std_dev
    end
  end

end
