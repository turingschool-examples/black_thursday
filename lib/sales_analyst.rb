require './lib/sales_engine'

class SalesAnalyst
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
    avg_items = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    # counts.each_with_index
    # make std dev method for merchant
    sales_engine.merchants.merchants.select do |merchant|
      sales_engine.find_merchant_items(merchant.id).count > (avg_items + std_dev)
      # merchant.std_dev > 2 - math Module
    end
  end

end
