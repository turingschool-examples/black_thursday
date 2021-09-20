require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/item'
require './lib/merchant'
require 'csv'
require 'pry'

class SalesAnalyst
  attr_reader :analyst_items,
              :analyst_merchants,
              :average_items_per_merchant,
              :average_items_per_merchant_standard_deviation

#How to access data insie this class:
    # => @analyst_items.all.count
    # => or
    # => @analyst_merchants.all.upcase
    # => get it? use "all" after the @analyst_whatever to get to the good stuff,
    # => then call the method after the all. Love you all, good night.

  def initialize(data)
    @analyst_items = data[:items]
    @analyst_merchants = data[:merchants]
  end

  def average_items_per_merchant
    (@analyst_items.all.count.to_f / @analyst_merchants.all.count.to_f).round(2)
  end

  def items_per_merchant_hashes
    items_per_merchant_hashes = []
    item_count = 0
    @analyst_merchants.all.each do |merchant|
      item_count = 0
      @analyst_items.all.each do |item|
        if item.merchant_id == merchant.id
          item_count += 1
        end
      end
    items_per_merchant_hashes << {:merchant => merchant, :item_count => item_count}
    end
    items_per_merchant_hashes
  end

  def average_items_per_merchant_standard_deviation
    sum = 0
    aipm = average_items_per_merchant
    items_per_merchant_hashes.each do |ipm|
      sum += (ipm[:item_count] - aipm)**2
    end
    std = Math.sqrt(sum / items_per_merchant_hashes.count).round(2)
    std
  end

   def merchants_with_high_item_count
     std = average_items_per_merchant_standard_deviation
     aipm = average_items_per_merchant
     mwhic = []
     items_per_merchant_hashes.each do |ipm|
       if ipm[:item_count] > aipm + std
         mwhic << ipm[:merchant]
       end
     end
     mwhic
  end

  def average_item_price_for_merchant(merchant_id)

  end

  def average_average_price_per_merchant

  end

  def golden_items

  end
end
