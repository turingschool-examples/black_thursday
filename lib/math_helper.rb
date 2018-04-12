# frozen_string_literal: true

# Module for math.
module MathHelper
  def standard_deviation(list, average)
    numerator = list.map { |list_items| (list_items.to_f - average)**2 }
    denominator = list.length
    Math.sqrt(numerator.inject(:+) / denominator).round(2)
  end

  def average(list)
    (list.inject(:+).to_f / list.length).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @sales_engine.merchants.find_by_id(merchant_id)
    all_items = merchant.items.map(&:unit_price)
    (all_items.inject(:+) / all_items.length).round(2)
  end

  # def two_standard_deviations_above(average, std_dev)
  #   average + (2 * std_dev)
  # end
end
