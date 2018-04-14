# frozen_string_literal: true

class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @all_items_per_merchant = all_items_per_merchant
    @number_of_items_per_merchant = @all_items_per_merchant.values.map(&:count)
  end

  def average_items_per_merchant
    item_count = @all_items_per_merchant.values.map(&:count)
    item_sum = find_sum(item_count)
    (item_sum.to_f / @all_items_per_merchant.values.count).round(2)
  end

  def all_items_per_merchant
    @sales_engine.all_items_per_merchant
  end

  def find_sum(numbers)
    numbers.inject(0) { |sum, number| sum + number }.to_f
  end

  def find_mean(numbers)
    sum = find_sum(numbers)
    sum / numbers.count
  end

  def standard_deviation(numbers)
    mean = find_mean(numbers)
    diff_from_mean = numbers.map do |number|
      mean - number
    end
    squared = diff_from_mean.map do |number|
      number**2
    end
    sum = find_sum(squared)
    sum_over_count = sum / (numbers.count - 1)
    Math.sqrt(sum_over_count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(@number_of_items_per_merchant).round(2)
  end

  def std_dev_above_mean(data_point, mean, standard_deviation)
    std_dev = standard_deviation
    diff_from_mean = data_point - mean
    (diff_from_mean / std_dev).round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    item_num_mean = find_mean(@number_of_items_per_merchant)
    high_item_count_merchants = []
    @all_items_per_merchant.each_pair do |merchant,items|
      if std_dev_above_mean(items.count, item_num_mean, std_dev) >= 1
        high_item_count_merchants << @sales_engine.merchants.find_by_id(merchant)
      end
    end
    high_item_count_merchants
  end

  def average_item_price_for_merchant(merchant_id)
    unit_prices= []
    new_key = @all_items_per_merchant.select{|key, hash| key == merchant_id}
    new_key.values.flatten.map{|value| unit_prices << value.unit_price}
    (find_mean2(unit_prices)).round(2)
  end

  def find_sum2(numbers)
    numbers.inject(0) { |sum, number| sum + number }
  end

  def find_mean2(numbers)
    sum = find_sum2(numbers)
    sum / numbers.count
  end

  def average_average_price_per_merchant
    all_unit_prices= []
    all_values = @all_items_per_merchant.values
    all_values 
    (find_mean2(all_unit_prices)).round(2)
  end



end
