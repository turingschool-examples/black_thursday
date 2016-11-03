require_relative '../lib/statistics'

class SalesAnalyst

  include Statistics

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def items
    sales_engine.all_items
  end

  def merchants
    sales_engine.all_merchants
  end

  def average_items_per_merchant
    (items.count / merchants.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    array1   = merchants.map {|merchant| merchant.items.count}
    array2   = merchants
    average  = average_items_per_merchant
    standard_deviation(array1, array2, average)
  end

  def merchants_with_high_item_count
    mean    = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    merchants.find_all do |merchant|
      merchant.items.count > (mean + std_dev)
    end
  end

  def average_item_price_for_merchant(id)
    merch_items = merchants.find_by_id(id).items
    return 0 if merch_items.empty?
    prices = merch_items.map do |row|
      row.unit_price
    end.reduce(:+) / merch_items.count
    prices.round(2)
  end

  def average_average_price_per_merchant
    sum = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.reduce(:+)
    (sum / merchants.count).round(2)
  end

  def golden_items
    mean    = average_item_price
    std_dev = item_price_standard_deviation
    items.find_all do |item|
      item.unit_price > (mean + (std_dev * 2))
    end
  end

  def average_item_price
    sum   = items.map { |item| item.unit_price }.reduce(:+)
    sum / items.count
  end

  def item_price_standard_deviation
    array1  = items.map {|item| item.unit_price}
    array2  = items
    average = average_item_price
    standard_deviation(array1, array2, average)
  end

end
