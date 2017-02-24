require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesAnalyst
  attr_reader :se

  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
    ((se.items.all.count.to_f) / (se.merchants.all.count.to_f)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    totals = total_items_each_merchant
    numerator = calculate_numerator(totals)
    denominator = (se.merchants.all.count - 1).to_f
    Math.sqrt(numerator / denominator).round(2)
  end

  def total_items_each_merchant
    se.merchants.all.map do |merchant|
      merchant.items.count
    end
  end

  def calculate_numerator(totals)
    totals.map do |merchant_total|
      (merchant_total - average_items_per_merchant)**2
    end.reduce(:+)
  end

  def merchants_with_high_item_count
    # if merchant has more items than standard deviation, put it in the array
    
  end

end