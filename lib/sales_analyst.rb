require_relative 'sales_engine'
require 'pry'

class SalesAnalyst

  include Math

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    (@se.items.items.count.to_f / @se.merchants.merchants.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchant_items = number_of_items_per_merchant
    variance = get_variance(merchant_items)
    sqrt(variance.sum / (@se.merchants.merchants.count.to_f - 1)).round(2)
  end

  def number_of_items_per_merchant
    number_of_items_per_merchant = []
    @se.merchants.merchants.each do |merchant_obj|
      merchant_id = merchant_obj.id
      items = @se.items.find_all_by_merchant_id(merchant_id)
      number_of_items_per_merchant << items.count
    end
    number_of_items_per_merchant
  end

  def get_variance(merchant_items)
    average = average_items_per_merchant
    merchant_items.map do |num|
      (num - average)**2
    end
  end

  def merchants_with_high_item_count
    high_item_merchants = []
    target = average_items_per_merchant +
             average_items_per_merchant_standard_deviation
    @se.merchants.merchants.each do |merchant_obj|
      merchant_id = merchant_obj.id
      items = @se.items.find_all_by_merchant_id(merchant_id)
      if items.count >= target
        high_item_merchants << merchant_obj
      end
    end
    high_item_merchants
  end

end