class SalesAnalyst
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def items_per_merchant
    merchants = @sales_engine.merchants.all
    merchants.map do |merchant|
      merchant.items.count
    end
  end

  def average_items_per_merchant
    items_per_merchant.inject(0.0) do |sum, num|
      sum + num
    end / items_per_merchant.count.round(2)
  end

  def differences_squared
    items_per_merchant.map do |num|
      (num - average_items_per_merchant)**2
    end
  end

  def sum_of_differences_squared
    differences_squared.inject(0) { |sum, num| sum + num }
  end

  def average_items_per_merchant_standard_deviation
    divisor = items_per_merchant.count - 1
    Math.sqrt(sum_of_differences_squared / divisor).round(2)
  end

  def merchants_with_high_item_count
    zipped = items_per_merchant.zip(@sales_engine.merchants.all)
    sum = average_items_per_merchant + average_items_per_merchant_standard_deviation
    found = zipped.find_all { |merchant| merchant[0] > sum }
    found.map { |merchant| merchant[1] }
  end
end
