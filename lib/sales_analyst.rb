require_relative 'sales_engine'
require_relative 'stats'

class SalesAnalyst
  include Stats
  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    (se.all_items.count.to_f / se.all_merchants.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(all_items_per_merchant).round(2)
  end

  def merchants_with_high_item_count
    avg     = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    bar     = avg + std_dev
    high_sell = []
    high_selling_merchants.map do |merchant|
      high_sell << merchant[0] if merchant[1] > bar
    end
    high_sell
  end


end
