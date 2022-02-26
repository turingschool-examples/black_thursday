require_relative 'item_repository'
require 'bigdecimal/util'

class SalesAnalyst
  attr_reader :merchants, :items
  def initialize(merchants, items)
    @merchants = merchants
    @items = items
  end

  def list_all_items_by_merchant
    items_by_merchant = []

    @items.all.each do |item|
      items_by_merchant <<  @items.find_all_by_merchant_id(item.merchant_id)
    end
    items_by_merchant.uniq
  end

  def average_items_per_merchant
    all_items_by_merchant = list_all_items_by_merchant
    nums = []
    all_items_by_merchant.uniq.each { |sub_arr| nums << sub_arr.length }
    (nums.sum(0.0) / nums.length).round(2)
  end


  def average_items_per_merchant_standard_deviation
    all_items_by_merchant = list_all_items_by_merchant
    mean = average_items_per_merchant
    math_arr = []

    all_items_by_merchant.each { |sub_arr| math_arr << (sub_arr.length - mean) ** 2 }
    Math.sqrt((math_arr.sum)/474).round(2)
  end

  def merchants_with_high_item_count
    all_items_by_merchant = list_all_items_by_merchant
    average = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation

    high_item_count = all_items_by_merchant.find_all{|merchant| merchant.length > (average + std_dev)}
    merchant_ids = high_item_count.map{|merchants|merchants[0].merchant_id}
    merchant_ids.map{|id|@merchants.find_by_id(id)}
  end

  def average_item_price_for_merchant(id)
    all_items = @items.find_all_by_merchant_id(id)
    all_prices = all_items.map {|item|item.unit_price}
    average = all_prices.sum(0.0)/all_items.length
    average.round(2)
  end

  def average_average_price_per_merchant
    sum = 0
    item_array = list_all_items_by_merchant
    item_array.each do |elem|
      sum += average_item_price_for_merchant(elem[0].merchant_id)
    end
    (sum / item_array.length).round(2)
  end

  def average_item_price
    total_price = 0
    @items.all.each do |item|
      total_price += item.unit_price
    end
    (total_price / @items.all.length).round(2)
  end

end
