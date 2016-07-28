require_relative '../lib/standard_deviation'

class ItemAnalyst
  include StandardDeviation

  attr_reader :all_items

  def initialize(all_items)
    @all_items = all_items
  end

  def item_prices
    all_items.map do |item|
      item.unit_price
    end
  end

  def average_price_standard_deviation
    standard_deviation(item_prices).round(2)
  end

  def golden_items
    avg = mean(item_prices)
    std_dev = average_price_standard_deviation
    all_items.find_all do |item|
      item.unit_price > (avg + (std_dev * 2))
    end
  end

end
