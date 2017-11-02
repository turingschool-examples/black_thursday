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
      result = count - average_items_per_merchant
      result.round(2)
    end
  end

  def squared
    variance_of_items.map do |count|
      count ** 2
    end
  end

  def sum_array
     squared.reduce(0) do |sum, number|
      sum + number
    end.round(2)
  end

  def average_items_per_merchant_standard_deviation
    result = sum_array / (sales_engine.merchants.merchants.count - 1)
    Math.sqrt(result).round(2)
  end

end
