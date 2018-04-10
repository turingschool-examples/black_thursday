require_relative '../lib/sales_engine'
# Sales Analyst class for analyzing data
class SalesAnalyst
  attr_reader :engine
  def initialize(sales_engine)
    @engine = sales_engine
  end

  def average_items_per_merchant
    merch_count = @engine.merchants.all.count
    item_count = @engine.items.all.count
    (item_count / merch_count).to_f.round(2)
  end

  def items_per_merchant
    items_by_merch = @engine.items.all.group_by(&:merchant_id)

    items_by_merch.each_key do |key|
      items_by_merch[key] = items_by_merch[key].length
    end
  end

  def average_items_per_merchant_standard_deviation
    ipm = items_per_merchant.values.sort
    array = ipm.map do |items_per_merch|
      (items_per_merch - average_items_per_merchant)**2
    end

    variance = array.inject(0) do |sum, num|
      sum + num
    end

    std_dev = variance / (array.count - 1)
    Math.sqrt(std_dev).to_f.round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    items_per_merchant.map do |id, num_of_items|
      @engine.merchants.find_by_id(id) if num_of_items >= avg + std_dev
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    total = items_per_merchant[merchant_id]
    items_by_merch = @engine.items.all.group_by(&:merchant_id)
    sum_of_prices = items_by_merch[merchant_id].inject(0) do |sum, item|
      sum + item.unit_price
    end
    sum_of_prices / total
  end

  def average_average_price_per_merchant
    all_merchants = @engine.merchants.all
    all_averages = all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    all_averages.inject(:+) / all_averages.count
  end

  def average_item_price
    total_items = @engine.items.all.count
    all_item_prices = @engine.items.all.map(&:unit_price)
    all_item_prices.inject(:+) / total_items
  end

  def average_item_price_standard_deviation
    array = @engine.items.items.values.map(&:unit_price).sort
    variance = array.inject(0) do |sum, price|
      sum + ((price - average_item_price)**2)
    end
    std_dev = variance / (array.count - 1)
    Math.sqrt(std_dev).to_f.round(2)
  end

  def golden_items
  end
end
