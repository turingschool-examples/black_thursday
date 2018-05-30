require 'pry'

class SalesAnalyst
  # attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    number_of_items     = @engine.items.all.count
    number_of_merchants = @engine.merchants.all.count
    (number_of_items/number_of_merchants.to_f).round(2)
  end

  def items_by_merchant_id
    @engine.items.all.group_by do |item|
      item.merchant_id
    end
  end

  def item_count_by_merchant_id
    items_by_merchant_id.map do |merchant_id,item_list|
      item_list.count
    end
  end

  def variance
    mean = average_items_per_merchant
    item_count_by_merchant_id.map do |count|
      (count - mean)**2
    end
  end

  def sum_of_variance
    variance.inject(:+)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(sum_of_variance/(item_count_by_merchant_id.count-1)).round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    items_by_merchant_id.map do |merchant_id,item_list|
      @engine.merchants.find_by_id(merchant_id) if item_list.count > mean + std_dev
    end.compact
  end

  # helper method to return group_by hash with AVG prices
  def average_item_price_for_merchant(merchant_id)
    prices = items_by_merchant_id[merchant_id].map do |item|
      item.unit_price
    end
    (prices.inject(:+)/prices.count).round(2)
  end

  # brute force - WAY TOO INTENSIVE
  def average_average_price_per_merchant
    avg_prices = items_by_merchant_id.keys.map do |merchant_id|
      average_item_price_for_merchant(merchant_id)
    end
    (avg_prices.inject(:+)/avg_prices.count).round(2)
  end

end
