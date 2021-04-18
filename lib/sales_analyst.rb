require_relative './sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def num_of_items_per_merchant
    all_items = @sales_engine.items.all
    all_merchants = @sales_engine.merchants.all

    all_merchants.each_with_object({}) do |merchant, total_per_merchant|
      total_items = all_items.count do |item|
        item.merchant_id == merchant.id
      end
      total_per_merchant[merchant] = total_items
    end
  end

  def average_items_per_merchant
    items = @sales_engine.items.all
    merchants = @sales_engine.merchants.all

    average = items.length.to_f / merchants.length
    average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    item_count_per_merchant = num_of_items_per_merchant
    mean = average_items_per_merchant

    item_counts = item_count_per_merchant.values

    sums = item_counts.sum do |item_count|
      (item_count - mean)**2
    end

    std_dev = Math.sqrt(sums / (item_counts.length - 1).to_f)
    std_dev.round(2)
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
    merchants = @sales_engine.merchants.all
    sum_of_averages = merchants.sum do |merchant|
      average_item_price_for_merchant(merchant.id) unless num_of_items_per_merchant[merchant] == 0
    end
    average_average_price = sum_of_averages / merchants.length
    average_average_price.round(2)
  end

  # def golden_items
  #   mean = average_average_price_per_merchant
  #   std_dev =
  #
  #   min_price = standard_deviations_of_mean(mean, std_dev, 2)
  # end
end
