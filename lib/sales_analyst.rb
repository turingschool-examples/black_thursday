require 'csv'
require_relative 'sales_engine'

class SalesAnalyst
  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
    (@se.item_repo_total_items.to_f / @se.item_repo_total_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    sum = @se.item_repo_items_per_merchant.sum do |items|
      (items - average_items_per_merchant) ** 2
    end
    std_dev = sum / (@se.item_repo_total_merchants - 1)
    Math.sqrt(std_dev).round(2)
  end

  def merchants_with_high_item_count
    high_merchants = []
    @se.item_repo_group_items_by_merchant.each do |merchant, items|
      if items.length - average_items_per_merchant_standard_deviation > average_items_per_merchant
        high_merchants << @se.merchant_repo_find_by_id(merchant)
      end
    end
    high_merchants
  end

  def average_item_price_for_merchant(merchant_id)
    (@se.item_repo_merchant_price_sum(merchant_id) / @se.item_repo_total_items_by_merchant(merchant_id)).round(2)
  end

  def average_average_price_per_merchant
    average_total = 0
    @se.item_repo_group_items_by_merchant.each do |merchant, items|
      average_total += average_item_price_for_merchant(merchant)
    end
    (average_total / @se.item_repo_group_items_by_merchant.keys.length).round(2)
  end
end
