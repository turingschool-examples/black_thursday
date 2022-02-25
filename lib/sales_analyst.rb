require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require 'pry'
require 'CSV'

class SalesAnalyst



  def initialize(merchants, items)
    @merchants = merchants
    @items = items
  end

  def average_items_per_merchant
    merchant_ids = @items.items.map {|item| item.merchant_id}
    merchant_items = Hash.new(0)
    merchant_ids.each do |id|
      merchant_items[id] += 1
    end

    ((merchant_items.values.sum).to_f / merchant_items.keys.count).round(2)

  end
# set = [3,4,5]
#
# std_dev = sqrt( ( (3-4)^2+(4-4)^2+(5-4)^2 ) / 2 )
  def average_items_per_merchant_standard_deviation
    merchant_ids = @items.items.map {|item| item.merchant_id}
    merchant_items = Hash.new(0)
    merchant_ids.each do |id|
      merchant_items[id] += 1
    end

    average_merchant_items = ((merchant_items.values.sum).to_f / merchant_items.keys.count)
    empty = []
    merchant_items.values.each do |number|
      result = (number - average_merchant_items) * (number - average_merchant_items)
      empty << result
    end

    Math.sqrt(empty.sum / (merchant_items.count - 1)).round(2)
  end

  def merchants_with_high_item_count
    merchant_ids = @items.items.map {|item| item.merchant_id}
    merchant_items = Hash.new(0)
    merchant_ids.each do |id|
      merchant_items[id] += 1
    end

    average_merchant_items = ((merchant_items.values.sum).to_f / merchant_items.keys.count)
    item_count_standard = average_merchant_items + average_items_per_merchant_standard_deviation

    # h = merchant_items.find_all do |key,value|
    #   if value > item_count_standard
    #     key
    #   end
    # end
    #
    # h.map {|key| key[0]}


  end
end
