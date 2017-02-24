require 'pry'

class SalesAnalyst
  attr_reader :se

  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
    (se.items.all.count.to_f / se.merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    avg = se.items.all.count.to_f / se.merchants.all.count.to_f

    squared_diffs = se.merchants.all.map do |merchant|
      (merchant.items.count - avg) ** 2
    end.reduce(:+)
    std_dev = Math.sqrt(squared_diffs / (se.merchants.all.count - 1)).round(2)
  end

end
