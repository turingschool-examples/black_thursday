require './lib/entry'
require_relative 'entry'
require './lib/item_repository.rb'

class SalesAnalyst
  attr_accessor :item_repository, :merchant_repository

  def initialize(item_repository, merchant_repository)
    @item_repository = item_repository
    @merchant_repository = merchant_repository
  end

  def average_items_per_merchant
    (@item_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    x = @item_repository.all.find_all { |item| item.merchant_id == merchant_id }
    y = x.map do |item|
      item.unit_price
    end
      (y.sum / x.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    # x is a hash - merchant id's are assigned to keys and the values are arrays of their items
    x = @item_repository.all.group_by {|item| item.merchant_id}
    y = x.flat_map {|_,value|value.count}
    z = y.map {|item_count|((item_count - average_items_per_merchant)**2)}
    Math.sqrt(((z.sum) / (z.count - 1)).to_f.round(2)).round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    x = @item_repository.all.group_by {|item| item.merchant_id}
    merchant_id_array = x.keys.find_all do |id|
      @item_repository.find_all_by_merchant_id(id).count > (std_dev + average_items_per_merchant)
    end
    merchant_array = merchant_id_array.map {|merchant_id|@merchant_repository.find_by_id(merchant_id)}
  end

  def average_average_price_per_merchant
    x = 0
    @merchant_repository.all.map do |merchant|
      x += average_item_price_for_merchant(merchant.id)
    end
    (x / @merchant_repository.all.count).round(2)
  end

  def golden_items
    x = average_average_price_per_merchant
    y = average_items_per_merchant_standard_deviation
    @item_repository.all.select do |item|
      item.unit_price > (x + y * 2)
    end
  end

end
