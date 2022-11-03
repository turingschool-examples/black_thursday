require './lib/item_repository'
require './lib/merchant_repository'
require './lib/item'
require './lib/merchant'
require 'bigdecimal'
require_relative 'reposable'

class SalesAnalyst
  attr_reader :merchants, :items

  def initialize(merchants,items)
    @merchants = merchants
    @items = items
  end

  def average_items_per_merchant
    (@items.all.count / @merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation    
    Math.sqrt(sum_square_diff/(item_counts.length-1)).round(2)
  end

  def merchants_with_high_item_count
    avg = average_items_per_merchant
    stdev = average_items_per_merchant_standard_deviation

    @merchants.all.find_all do |merchant|
      @items.find_all_by_merchant_id(merchant.id).count > avg + stdev
    end
  end

  def average_item_price_for_merchant(id)
    sum = @items.find_all_by_merchant_id(id).sum do |item|
      item.unit_price
    end
    avg = sum.to_f / @items.find_all_by_merchant_id(id).count
    BigDecimal(avg,4)
  end

  def sum_square_diff
    item_counts.map do |count|
      (count - average_items_per_merchant)**2
    end.sum
  end

  def item_counts
    @merchants.all.map do |merchant|
      @items.find_all_by_merchant_id(merchant.id).count
    end
  end
end