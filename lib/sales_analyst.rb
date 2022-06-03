require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'item'
require_relative 'merchant'
# require "./lib/sales_engine"
require_relative 'sales_engine'
require 'pry'
class SalesAnalyst < SalesEngine

  def initialize(items_path,merchants_path)
    super
  end
  # binding.pry
  def average_items_per_merchant
    (@items.all.count / @merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    item_count = @merchants.all.map do |merchant|
      @items.find_all_by_merchant_id(merchant.id).length
    end

    total_sum = item_count.sum do |count|
      (count - average_items_per_merchant)**2
    end

    Math.sqrt(total_sum / (@merchants.all.length - 1)).round(2)
  end
end
