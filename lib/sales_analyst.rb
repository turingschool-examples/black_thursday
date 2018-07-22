require 'pry'
require_relative 'sales_engine'

class SalesAnalyst
  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def average_items_per_merchant
    (@items.all.count.to_f / @merchants.all.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchant_ids = @merchants.all.map do |merchant|
      merchant.id
    end
    items_from_each_merchant = merchant_ids.map do |merchant_id|
      @items.find_all_by_merchant_id(merchant_id).count
    end
    difference_squared = items_from_each_merchant.map do |number|
      (number - average_items_per_merchant) ** 2
    end
    summed_differences = difference_squared.inject(:+)
    sum = summed_differences / (items_from_each_merchant.count - 1)
    std_dev = Math.sqrt(sum).round(2)
  end

end
