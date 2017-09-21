require_relative './finder'

module MerchantGoldenItems

  include Finder

  def average_item(items)
    all_items_sum = items.all.reduce(0) do |sum, item|
      sum + item.unit_price_float
    end
    all_items_sum / items.all.count
  end

  def golden_numerator(items)
    items.all.reduce(0) do |sum, item|
      sum + ((item.unit_price_float - average_item(items)) ** 2)
    end
  end

  def standard_deviation_for_item(items, merchants)
    Math.sqrt(golden_numerator(items) / (items.all.count - 1)).round(3)
  end

  def avg_item_plus_2x_std_dev(items, merchants)
    average_item(items) + (standard_deviation_for_item(items, merchants) * 2)
  end

  def two_standard_deviations_above(items, merchants)
    difference = avg_item_plus_2x_std_dev(items, merchants)
    items.all.find_all do |item|
      item.unit_price_float  >= difference
    end
  end
end
