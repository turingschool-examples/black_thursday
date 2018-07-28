require_relative 'merchant_repo'
require_relative 'item_repo'
require 'time'
require 'bigdecimal'
require 'pry'

class SalesAnalyst

  attr_reader :merchants, :items

  def initialize(merchant_repo, item_repo)
    @merchants = merchant_repo
    @items = item_repo
  end

  def average_items_per_merchant
    total_items = @items.all.count.to_f
    total_merchants = @merchants.all.count.to_f
    (total_items / total_merchants).round(2)
  end

  def return_array_of_unique_merchants
    if @merchants != nil
      return @merchants.all.uniq do |merchant|
        merchant.id
      end
    end
  end

  def return_hash_of_merchants_with_items
    hash = Hash.new(0)
    return_array_of_unique_merchants.each do |merchant|
      mer_items = @items.all.find_all do |item|
        item.merchant_id == merchant.id
      end
      hash[merchant.id] = mer_items
    end
    hash
  end

  def total_count_items_by_merchant
    merchants = return_array_of_unique_merchants
    merchant_item_total = []
    merchants.each do |merchant|
      merchant_items = @items.all.find_all do |item|
        item.merchant_id == merchant.id
      end
      merchant_item_total << merchant_items.count
    end
    merchant_item_total
  end

  def difference_from_average
    count = total_count_items_by_merchant
    count.map do |element|
      element.to_f - average_items_per_merchant
    end
  end

  def square_each_element
    difference_from_average.map do |element|
      element * element
    end
  end

  def sum_array
    sum = 0
    square_each_element.each do |element|
      sum += element
    end
    sum
  end

  def average_items_per_merchant_standard_deviation
    average_items_per_merchant
    total_count_items_by_merchant
    difference_from_average
    square_each_element
    sum = sum_array
    result = sum / (@merchants.all.count - 1)
    result = Math.sqrt(result).round(2)
  end

  def merchants_with_high_item_count
    high_item_count = average_items_per_merchant_standard_deviation + average_items_per_merchant
    id_count_combo = return_array_of_unique_merchants.zip(total_count_items_by_merchant)
    merchant_ids = id_count_combo.find_all do |element|
      if element[1] >= high_item_count
        element[0]
      end
    end
    merchant_ids[0].delete_at(-1)
    merchant_ids.flatten

  end

  # def merchants_high_item_count
  #   merchants_ids_for_high_item_count.each do |id|
  #     @merchants.find_by_id(id)
  #   end
  # end

end
