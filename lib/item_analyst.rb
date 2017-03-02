require_relative 'helper'

module ItemAnalyst
 def all_item_prices
    all_items.map do |item|
      item.unit_price
    end
  end

  def average_item_price
    average(all_item_prices)
  end

  def item_price_standard_deviation
    standard_deviation(all_item_prices)
  end

  def golden_items
    two_sd = two_standard_deviations_above_mean(all_item_prices)
    all_items.find_all do |item|
      item.unit_price > two_sd
    end
  end
end