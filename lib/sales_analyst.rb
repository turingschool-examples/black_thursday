require_relative 'sales_engine'

class SalesAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def items
    sales_engine.items.all
  end

  def merchants
    sales_engine.merchants.all
  end

  def total_merchant_count
    merchants.length
  end

  def total_item_count
    items.length
  end

  def item_count(merchant)
    merchant.items.length
  end

  def average_items_per_merchant
    (total_item_count.to_f / total_merchant_count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    set = merchants.map {|merchant| item_count(merchant)}
    standard_deviation(set, average_items_per_merchant)
  end

  def sum_of_squared_differences(set, average)
    set.reduce(0) {|sum, element| (element - average) ** 2}
  end

  def standard_deviation(set, average)
    sum = sum_of_squared_differences(set, average)
    standard_deviation = (sum / (set.length - 1)) ** (0.5)
    standard_deviation.round(2)
  end

  def merchants_with_high_item_count
    standard_deviation = average_items_per_merchant_standard_deviation
    threshold = average_items_per_merchant + standard_deviation
    merchants.find_all {|merchant| item_count(merchant) > threshold}
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    count = item_count(merchant)
    if count == 0
      BigDecimal(0)
    else
      average_price(merchant.items, count)
    end
  end

  def average_price(items, count)
    prices_sum = items.reduce(0) {|sum, item| sum += item.unit_price}
    prices_sum / count
  end

  def sum_of_averages
    merchants.reduce(0) do |sum, merchant|
      id = merchant.id
      sum += average_item_price_for_merchant(id)
    end
  end

  def average_average_price_per_merchant
    sum_of_averages / total_merchant_count
  end

  def golden_items
    threshold = golden_items_threshold
    items.find_all {|item| item.unit_price > threshold}
  end

  def golden_items_threshold
    average_item_price = average_price(items, total_item_count)
    set = items.map {|item| item.unit_price}
    standard_deviation = standard_deviation(set, average_item_price)
    average_item_price + standard_deviation * 2
  end

end

