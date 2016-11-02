class SalesAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    items = sales_engine.items.all.count.to_f
    merchants = sales_engine.merchants.all.count.to_f
    (items / merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(item_count_std_dev_numerator / item_count_std_dev_denominator).round(2)
  end

  def item_count_std_dev_numerator
    sales_engine.merchants.all.map do |merchant|
      distance_from_mean_squared(merchant.items.count)
    end.reduce(:+).to_f
  end

  def distance_from_mean_squared(item_count)
    ((item_count - average_items_per_merchant) ** 2).to_f
  end

  def item_count_std_dev_denominator
    (sales_engine.merchants.all.count - 1).to_f
  end

  def average_item_price_for_merchant(id)
    items = sales_engine.merchants.find_by_id(id).items
    sum_of_prices = items.map {|row| row.unit_price}.reduce(:+)
    (sum_of_prices / items.count).round(2)
  end

  def merchants_with_high_item_count
    mean    = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    sales_engine.merchants.all.find_all do |merchant|
      merchant.items.count > (mean + std_dev)
    end
  end

  # def golden_items
  #   mean    = average_average_price_per_merchant
    
  # end

end
