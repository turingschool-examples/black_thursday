require 'CSV'
require './lib/sales_engine'

class Analyst

  def initialize(engine)
    @engine = engine
  end

  # def average_items_per_merchant
  #   grouped_hash = @engine.items.group_by_merchant_id.map do |merchant|
  #     merchant[1].count
  # end
  # end

  def items_per_merchant
    @engine.items.group_by_merchant_id
  end

  def total_items_across_all_merchants
    items_per_merchant.values.flatten.count.to_f
  end

  def total_merchants
    items_per_merchant.keys.count
  end

  def average_items_per_merchant
    (total_items_across_all_merchants / total_merchants).round(2)
  end

  def all_items_by_merchant
    items_per_merchant.map do |merchant, items|
      items.count
    end
  end

  def difference_of_item_and_average_items
    all_items_by_merchant.map do |item|
      item - average_items_per_merchant
    end
  end

  def squares_of_differences
    difference_of_item_and_average_items.map do |difference|
      difference ** 2
    end
  end

  def sum_of_square_differences
    squares_of_differences.sum
  end

  def std_dev_variance
    all_items_by_merchant.count - 1
  end

  def sum_and_variance_quotient
    sum_of_square_differences / std_dev_variance
  end

  def standard_deviation
    (sum_and_variance_quotient ** 0.5).round(2)
  end

end
