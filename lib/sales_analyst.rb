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

  def item_count(merchant)
    merchant.items.length
  end

  def merchant_item_counts
    merchants.map {|merchant| BigDecimal(item_count(merchant))}
  end

  def average_items_per_merchant
    average(merchant_item_counts).round(2).to_f
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(merchant_item_counts).round(2).to_f
  end

  def sum_of_squared_differences(set, average)
    set.reduce(0) {|sum, element| sum += ((element - average) ** 2)}
  end

  def average(set)
    if set.empty?
      0
    else
      set.reduce(0) {|sum, num| sum += num}/set.length
    end
  end

  def standard_deviation(set)
    average = average(set)
    sum = sum_of_squared_differences(set, average)
    standard_deviation = (sum / (set.length - 1)) ** 0.5
    standard_deviation.round(2)
  end

  def merchants_with_high_item_count
    standard_deviation = average_items_per_merchant_standard_deviation
    threshold = average_items_per_merchant + standard_deviation
    merchants.find_all {|merchant| item_count(merchant) > threshold}
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    set = merchant.items.map {|item| item.unit_price}
    average(set).round(2)
  end

  def average_price(items)
    set = items.map {|item| item.unit_price}
    average(set).round(2)
  end

  def average_average_price_per_merchant
    set = merchants.map do |merchant|
      id = merchant.id
      average_item_price_for_merchant(id)
    end
    average(set).round(2)
  end

  def golden_items
    threshold = golden_items_threshold
    items.find_all {|item| item.unit_price > threshold}
  end

  def golden_items_threshold
    average_item_price = average_price(items)
    set = items.map {|item| item.unit_price}
    standard_deviation = standard_deviation(set)
    average_item_price + standard_deviation * 2
  end

end

