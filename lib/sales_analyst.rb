require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'item'
require_relative 'merchant'
require_relative 'sales_engine'
require 'pry'
class SalesAnalyst < SalesEngine

  def initialize(items_path,merchants_path)
    super
  end

  def average_items_per_merchant
    (@items.all.count / @merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    @item_count = @merchants.all.map do |merchant|
      @items.find_all_by_merchant_id(merchant.id).length
    end
    standard_deviation(@item_count, average_items_per_merchant)
  end

  def standard_deviation(counts, average)
    total_sum = counts.sum do |count|
      (count - average)**2
    end

    Math.sqrt(total_sum / (counts.length - 1)).round(2)
  end

  def merchants_with_high_item_count
    high_item_count = average_items_per_merchant + average_items_per_merchant_standard_deviation
    @merchants.all.find_all {|merchant| @items.find_all_by_merchant_id(merchant.id).length > high_item_count}

  end

  def golden_items
    item_list = @items.all.map{|item| item.unit_price}
    price_sum = @items.all.sum{|item| item.unit_price}
    average = price_sum / @items.all.length
    sd = standard_deviation(item_list, average)

    @items.all.find_all{|item| item.unit_price > (average + (sd * 2))}
  end
end
