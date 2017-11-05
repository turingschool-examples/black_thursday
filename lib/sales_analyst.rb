require_relative 'sales_engine'
require_relative 'math'

class SalesAnalyst
  include Math
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    total_items = sales_engine.items.items.count
    total_merchants = sales_engine.merchants.merchants.count
    (total_items.to_f / total_merchants.to_f).round(2)
  end

  def counts_per_merchant(method)
    sales_engine.merchants.merchants.map do |merchant|
      method.call(merchant.id).count
    end
  end

  def variance_of_items
    counts = counts_per_merchant(sales_engine.method(:find_merchant_items))
    counts.map do |count|
      result = (count - average_items_per_merchant)**2
      result.round(2)
    end
  end

  def sum_array
    variance_of_items.reduce(0) do |sum, number|
      sum + number
    end.round(2)
  end

  def average_items_per_merchant_standard_deviation
    result = sum_array / (sales_engine.merchants.merchants.count - 1)
    Math.sqrt(result).round(2)
  end

  def merchants_with_high_item_count
    counts = counts_per_merchant(sales_engine.method(:find_merchant_items))
    one_std_dev = mean(counts) + standard_deviation(counts)
    # counts.each_with_index
    # make std dev method for merchant
    sales_engine.merchants.merchants.select do |merchant|
      sales_engine.find_merchant_items(merchant.id).count > one_std_dev
      # merchant.std_dev > 2 - math Module
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merch_items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    sum_price = merch_items.reduce(0) do |sum, item|
      sum += item.unit_price
    end
    roundy = sum_price / merch_items.count
    roundy.round(2)
  end

  def average_average_price_per_merchant
    prices = sales_engine.merchants.merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    mean(prices).round(2)
  end

  def average_item_price
    all = sales_engine.items.all
    avg_item = all.reduce(0) do |sum, item|
      sum += item.unit_price
    end
    avg_avg = avg_item / sales_engine.items.all.count
    avg_avg.round(2)
  end

  def item_unit_price_list
    sales_engine.items.items.map { |item| item.unit_price }
  end

  def std_dev_item_price
    standard_deviation(item_unit_price_list)
  end

  def golden_items
    std_deviation = std_dev_item_price
    sales_engine.items.items.select do |item|
      item.unit_price > (std_deviation * 2)
    end
  end

  def average_invoices_per_merchant
    total_invoices = sales_engine.invoices.invoices.count
    total_merchants = sales_engine.merchants.merchants.count
    (total_invoices.to_f / total_merchants.to_f).round(2)
  end

end
