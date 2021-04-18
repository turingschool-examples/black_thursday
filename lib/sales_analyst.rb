require_relative './sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def num_of_items_per_merchant
    all_merchants.each_with_object({}) do |merchant, total_per_merchant|
      total_items = all_items.count do |item|
        item.merchant_id == merchant.id
      end
      total_per_merchant[merchant] = total_items
    end
  end

  def average_items_per_merchant
    average = all_items.length.to_f / all_merchants.length
    average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    item_count_per_merchant = num_of_items_per_merchant
    mean = average_items_per_merchant

    item_counts = item_count_per_merchant.values
    std_dev = standard_deviation(item_counts, mean)
  end

  def standard_deviations_of_mean(mean, std_dev, n = 1)
    std_dev_n = std_dev * n
    mean + std_dev_n
  end

  def merchants_with_high_item_count
    mean = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation

    z = standard_deviations_of_mean(mean, std_dev)

    merchants = []
    num_of_items_per_merchant.each_pair do |merchant, item_count|
      merchants << merchant if item_count >= z
    end
    merchants
  end

  def average_item_price_for_merchant(merchant_id)
    items = @sales_engine.items.find_all_by_merchant_id(merchant_id)
    if items.empty?
      nil
    else
      items_sum = items.sum(&:unit_price)
      average_price = items_sum / items.length
      average_price.round(2)
    end
  end

  def average_average_price_per_merchant
    sum_of_averages = all_merchants.sum do |merchant|
      average_item_price_for_merchant(merchant.id) unless num_of_items_per_merchant[merchant] == 0
    end
    average_average_price = sum_of_averages / all_merchants.length
    average_average_price.round(2)
  end

  def golden_items
    mean = all_items.sum(&:unit_price) / all_items.length
    item_prices = all_items.map {|item| item.unit_price}
    std_dev = standard_deviation(item_prices, mean)
    min_price = standard_deviations_of_mean(mean, std_dev, 2)
    all_items.find_all {|item| item.unit_price > min_price }
  end

  def standard_deviation(values, mean)
    sums = values.sum {|value| (value - mean)**2 }
    std_dev =  Math.sqrt(sums / (values.length - 1).to_f)
    std_dev.round(2)
  end

  def all_items
    @sales_engine.all_items
  end

  def all_merchants
    @sales_engine.all_merchants
  end
end
