require_relative '../lib/sales_analyst'
require_relative '../lib/repo_module'

class SalesAnalyst
  include RepoModule

  attr_reader :item_repo,
              :merchant_repo

  def initialize(item_repo, merchant_repo)
    @item_repo = item_repo
    @merchant_repo = merchant_repo
  end

  # def items_per_merchant_array
  #   @merchant_repo.all.map do |merchant|
  #     @item_repo.all.find_all do |item|
  #       merchant.id == item.merchant_id
  #     end.count
  #   end
  # end

  def sum(array)
    type = 0 if array[0].class != BigDecimal
    type = BigDecimal.new(0,4) if array[0].class == BigDecimal
      array.inject(type) do |sum, price|
        price + sum
    end
  end

  def merchant_hash
    return_hash = {}
    @merchant_repo.all.each do |merchant|
      return_hash[merchant] = @item_repo.all.find_all do |item|
        merchant.id == item.merchant_id
      end
    end
    return_hash
  end

  def merchants_with_high_item_count_hash
    merchant_hash.find_all do |key, value|
      value.length >= per_merchant_standard_deviation(@items) + average_items_per_merchant
    end.to_h
  end

  def merchants_with_high_item_count
    merchants_with_high_item_count_hash.keys
  end

  def average_item_price_for_merchant(search_id)
    merchant_array = merchant_hash.find do |merchant, items|
      merchant.id == search_id
    end
    bd_array = merchant_array[1].map do |item|
      item.unit_price
    end
    (sum(bd_array)/bd_array.length).round(2)
  end

  def average_average_price_per_merchant
    array = []
    merchant_hash.each do |key, value|
      array << average_item_price_for_merchant(key.id)
    end

    (sum(array)/array.length).round(2)
  end

  def golden_items
    dev = calculate_std_dev_for_items
    @item_repo.all.find_all do |item|
      item.unit_price >= dev*2
    end
  end

#standard deviation for items per merchant
  # def average_items_per_merchant
  #   (@item_repo.all.count.to_f / @merchant_repo.all.count).round(2)
  # end
  #
  # def subtract_square_sum_array_for_items_per_merchant
  #   set = items_per_merchant_array
  #   average = average_items_per_merchant
  #   new_set = set.map do |element|
  #     (average - element)**2
  #   end
  #   sum(new_set)
  # end
  #
  # def average_items_per_merchant_standard_deviation
  #   step_one = subtract_square_sum_array_for_items_per_merchant
  #   step_two = step_one/(@merchant_repo.all.count - 1)
  #   Math.sqrt(step_two).round(2)
  # end

#stand deviation for item price
  def calculate_average_item_price
    prices = @item_repo.all.map do |item|
      item.unit_price
    end
    sum(prices)/@item_repo.all.length
  end

  def subtract_square_sum_array_for_unit_price
    set = @item_repo.all
    mean = calculate_average_item_price
    new_set = set.map do |element|
      (mean - element.unit_price)**2
    end
    sum(new_set)
  end

  def calculate_std_dev_for_items
    step_one = subtract_square_sum_array_for_unit_price
    step_two = step_one/(@item_repo.all.count - 1)
    Math.sqrt(step_two).round(2)
  end
end
