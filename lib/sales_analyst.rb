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

  def number_of_items_per_merchant
    se.merchants.all.map {|merchant| merchant.items.count}
  end

  def merchants_items_prices(merchant_id)
    se.merchants.find_by_id(merchant_id).items.map do |item|
      item.unit_price
    end
  end

  def average_item_price_for_merchant(merchant_id)
    float_answer = merchants_items_prices(merchant_id).reduce(0.0) { |sum, price|
       sum + price } / merchants_items_prices(merchant_id).count
    (float_answer / 100).round(2)
  end

  def average_items_per_merchant
    #cannot change
    (number_of_items_per_merchant.inject(0.0) {|sum, items| sum + items} / number_of_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    #cannot change
    Math.sqrt(variance).round(2)
  end

  def variance
    sum_deviations_from_the_mean / (number_of_merchants - 1)
  end

  def sum_deviations_from_the_mean
    number_of_items_per_merchant.inject(0) { |accum, items|
      accum + (items - average_items_per_merchant) ** 2 }
  end

  def one_standard_dev_above_mean_value
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    #cannot change
    se.merchants.all.find_all { |merchant|
       merchant.items.count > one_standard_dev_above_mean_value }
  end

  def average_price_per_merchant

  end

  def average_average_price_per_merchant

  end

  def golden_items

  end
end
