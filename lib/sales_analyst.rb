require_relative 'sales_engine'
require          'pry'
require          'pry'

class SalesAnalyst
  attr_reader :se

  def initialize(se)
    @se = se
  end

  def number_of_merchants
    se.merchants.all.count
  end

  def number_of_items
    se.items.all.count
  end

  def average_items_per_merchant #can't change
    (number_of_items_per_merchant.inject(0.0) {|sum, items| sum + items} / number_of_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation #can't change
    Math.sqrt(variance).round(2)
  end

  def variance
    sum_deviations_from_the_mean / (number_of_merchants - 1)
  end

  def number_of_items_per_merchant
    se.merchants.all.map {|merchant| merchant.items.count}
  end

  def sum_deviations_from_the_mean
    number_of_items_per_merchant.inject(0) { |accum, items|
      accum + (items - average_items_per_merchant) ** 2 }
  end

  def one_standard_dev_above_mean_value
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count #can't change
    se.merchants.all.find_all { |merchant|
       merchant.items.count > one_standard_dev_above_mean_value }
  end

  def merchants_items_prices(merchant_id)
    se.merchants.find_by_id(merchant_id).items.map do |item|
      item.unit_price
    end
  end

  def account_for_zero_items(total_items)
    if total_items.count == 0
      0
    else
      total_items.reduce(:+) / total_items.count
    end
  end

  def average_item_price_for_merchant(merchant_id) #can't change
    total = merchants_items_prices(merchant_id)
    (account_for_zero_items(total) / 100).round(2)
  end

  def all_merchants_averages
    all_merchants_ids = se.merchants.all.map(&:id)
    all_merchants_ids.map { |merchant_id|
      average_item_price_for_merchant(merchant_id)}
  end

  def average_average_price_per_merchant #can't change
    total_averages = all_merchants_averages.reduce(:+)
    (total_averages / all_merchants_averages.count).round(2)
  end

  def average_prices_of_all_items_gi
    total = se.items.all.reduce(0) {|sum, item|
       sum + item.unit_price}
    total / number_of_items
  end

  def sum_deviations_from_the_mean_gi
    se.items.all.inject(0) { |accum, items|
      accum + (items.unit_price - average_prices_of_all_items_gi) ** 2 }
  end

  def variance_gi
    sum_deviations_from_the_mean_gi / (number_of_items - 1)
  end

  def average_items_price_standard_deviation_gi
    Math.sqrt(variance_gi).round(2)
  end

  def two_standard_dev_above_mean_value_gi
     average_prices_of_all_items_gi + (average_items_price_standard_deviation_gi * 2)
  end

  def golden_items
    benchmark = two_standard_dev_above_mean_value_gi
    se.items.all.find_all { |item| item.unit_price > benchmark }
  end

end
