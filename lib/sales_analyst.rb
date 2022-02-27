require_relative 'merchant_repository'
require_relative 'sales_engine'
require_relative 'item_repository'
require 'pry'

class SalesAnalyst
attr_reader :item_num
  def initialize(merchants, items)
    @merchants = merchants
    @items = items
    @item_num = []
  end


  def average_items_per_merchant
    @merchants.all.each do |merchant|
      @item_num << @items.find_all_by_merchant_id(merchant.id).length
    end
    @average_items_per_merchant = (@item_num.sum(0.0)/@item_num.size).round(2)
  end


  def average_items_per_merchant_standard_deviation
    average_items_per_merchant
    item_num_diff_sqr = []
    @item_num.each do |num|
      item_num_diff_sqr << (num - @average_items_per_merchant) ** 2
    end
    standard_deviation = (Math.sqrt(item_num_diff_sqr.sum / @item_num.size)).round(2)
  end

  end
