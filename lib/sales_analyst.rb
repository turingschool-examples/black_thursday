require_relative 'sales_engine'

class SalesAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def merchants
    sales_engine.merchants.all
  end

  def total_merchant_count
    merchants.length
  end

  def total_item_count
    sales_engine.items.all.length
  end

  def item_count(merchant)
    merchant.items.length
  end

  def average_items_per_merchant
    (total_item_count.to_f / total_merchant_count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(merchants, average_items_per_merchant)
  end

  def standard_deviation(set, average)
    sum_of_squared_differences = set.reduce(0) do |sum, merchant|
      (item_count(merchant)- average) ** 2
    end
    standard_deviation = (sum_of_squared_differences / (total_merchant_count - 1)) ** (0.5)
    standard_deviation.round(2)
  end

  def merchants_with_high_item_count
    threshold = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchants.find_all {|merchant| merchant}
  end

end

