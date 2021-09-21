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
              :store_hashes,
              :average_items_per_merchant

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

  def store_hashes
    store_hashes = []
    stores_items = []
    @analyst_merchants.all.each do |merchant|
      stores_items = []
      @analyst_items.all.each do |item|
        if item.merchant_id == merchant.id
          stores_items << item
        end
      end
     store_hashes << {
       :merchant => merchant,
       :stores_items => stores_items,
       :item_count => stores_items.count}
     end
     store_hashes
  end

  def average_items_per_merchant_standard_deviation
    sum = 0
    aipm = average_items_per_merchant
    store_hashes.each do |store|
      sum += (store[:item_count] - aipm)**2
    end
    std = Math.sqrt(sum / store_hashes.count).round(2)
    std
  end

   def merchants_with_high_item_count
     std = average_items_per_merchant_standard_deviation
     aipm = average_items_per_merchant
     mwhic = []
     store_hashes.each do |store|
       if store[:item_count] > aipm + std
         mwhic << store[:merchant]
       end
     end
     mwhic
   end

  def average_item_price_for_merchant(merchant_id)
    (store_hashes.find do |store|
      store[:merchant].id == merchant_id
      end)[:items].each do |item|
    end
    #   sum = 0
    #     sum += item.unit_price
    #   end
    # average_item_price_for_m = (sum / store[:item_count]).round(2)
    #     end
    #   end
    #   average_item_price_for_m
  end

  #
  #       store
  # end


  # def average_average_price_per_merchant
  #
  # end
  #
  # def golden_items
  #
  # end
end
