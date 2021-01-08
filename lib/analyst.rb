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

  def merchants_with_high_item_count
    collector_array = []
    items_per_merchant.each do |item_id, items|
      if items.count.to_f > (standard_deviation + average_items_per_merchant)
        @engine.merchants.merchant_info.each do |merchant_id, total_merchants|
          if total_merchants.id == item_id
            collector_array << total_merchants.name
          end
        end
      end
    end
    collector_array
  end

  def items_to_be_averaged(merchant_number)
    collector = []
    items_per_merchant.each do |merchant_id, items|
      if merchant_id == merchant_number
        collector << items
      end
    end
    collector.flatten
  end

  def sum_item_price_for_merchant(merchant_number)
    total_price = 0
    items_to_be_averaged(merchant_number).each do |item|
      total_price += item.unit_price
    end
    total_price.to_i
  end

  def average_item_price_for_merchant(merchant_id)
    sum_item_price_for_merchant(merchant_id) / items_to_be_averaged(merchant_id).count
  end

  def merchant_id_collection
    items_per_merchant.keys
  end

  def average_item_prices_collection
    merchant_id_collection.map do |merchant_id|
      average_item_price_for_merchant(merchant_id)
    end
  end

  def sum_average_prices_collections
    average_item_prices_collection.sum
  end

  def average_average_price_per_merchant
    sum_average_prices_collections / merchant_id_collection.count
  end

  def difference_of_item_prices_and_total_average_item_prices
    average_item_prices_collection.map do |average|
      average - average_average_price_per_merchant
    end
  end

  def squares_of_average_prices_differences
    difference_of_item_prices_and_total_average_item_prices.map do |number|
      number ** 2
    end
  end

  def sum_of_square_item_price_differences
    squares_of_average_prices_differences.sum
  end

  def std_dev_item_price_variance
    merchant_id_collection.count - 1
  end

  def item_price_sum_and_variance_quotient
    sum_of_square_item_price_differences / std_dev_item_price_variance
  end

  def item_price_standard_deviation
    (item_price_sum_and_variance_quotient ** 0.5).round(2)
  end

  def double_item_price_standard_deviation
    item_price_standard_deviation * 2
  end

  def golden_items_critera
    double_item_price_standard_deviation + average_average_price_per_merchant
  end

  def item_collection
    items_per_merchant.values.flatten
  end

  # def golden_items
  #   golden_items_collector = []
  #   item_collection.each do |item|
  #     if item.unit_price > (double_item_price_standard_deviation + average_average_price_per_merchant)
  #       golden_items_collector << item
  #     end
  #   end
  #   golden_items_collector
  # end

  def golden_items
    item_collection.find_all do |item|
      item.unit_price > golden_items_critera
    end
  end


end
