require 'pry'


class SalesAnalyst
  attr_reader :items,
              :merchants

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def items_by_merchant
    @items.all.group_by {|item| item.merchant_id}
  end

  def average_items_per_merchant
    (items_by_merchant.values.flatten.count.to_f/items_by_merchant.count).round(2)
  end

  def sums(array)
    array.reduce(:+)
  end

  def variance(values_array, mean)
    sums(values_array.map {|value|(value - mean)**2})
  end

  def standard_deviation(values_array, mean)
     Math.sqrt(variance(values_array, mean)/(values_array.count-1)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    values_array = items_by_merchant.values.map {|items| items.count}
    standard_deviation(values_array, average_items_per_merchant)
  end

  def merchants_with_high_item_count
    merchants_hash = items_by_merchant.select do |id, items|
      (items.count - average_items_per_merchant) > 3.26
    end
    @merchants.all.find_all do |merchant|
      merchants_hash.include?(merchant.id)
    end

  end

  def average_item_price_for_merchant(merchant_id)
    total_items_for_merchant = @items.find_all_by_merchant_id(merchant_id).count
    sum_of_item_prices = @items.find_all_by_merchant_id(merchant_id).reduce(0) do |sum, item|
      sum + item.unit_price
    end
    (sum_of_item_prices / total_items_for_merchant).round(2)
  end

  def average_average_price_per_merchant
    merchant_id_array = @merchants.all.map { |merchant| merchant.id }
    array_of_averages = merchant_id_array.map do |merchant|
      average_item_price_for_merchant(merchant)
    end
    sum_of_averages = array_of_averages.reduce(0) do |sum, average|
        sum + average
    end
    (sum_of_averages / array_of_averages.count).round(2)
  end

  # def average_prices_per_merchant_standard_deviation
  #   items_per_merchant_array = items_by_merchant.values
  #   items_count = items_per_merchant_array.map do |items|
  #     items.count
  #   end
  #   squared_difference_array =
  #    items_count.map do |item_count|
  #      (item_count - average_items_per_merchant)**2
  #    end
  #    Math.sqrt(((squared_difference_array.reduce(:+))/(items_by_merchant.count-1))).round(2)
  # end
  #
  # def golden_items
  #
  #
  #
  # end



end
