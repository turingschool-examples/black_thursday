require_relative './sales_engine'
require 'bigdecimal'
require 'bigdecimal/util'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (sales_engine.all_items.to_f / sales_engine.all_merchants.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
  mean = sales_engine.merchants.all.map { |merchant| (merchant.items.length - average_items_per_merchant)** 2 }
  Math.sqrt(mean.reduce(:+) / sales_engine.merchants.all.count).round(2)
  end

  def item_count_per_merchant
    sales_engine.merchants.all.map { |merchant| merchant.items.count }
  end

  def merchants_with_high_item_count
    threshold = (average_items_per_merchant_standard_deviation + average_items_per_merchant)
    sales_engine.merchants.all.reduce([]) do |result, merchant|
      if merchant.items.count > threshold
        result << merchant
      end
      result
    end
  end

  def average_item_price_for_merchant(merchant_id)
    #find items by merchant id
    #find the prices associated with those items for that merchant
    #average those prices
  end

  def average_average_price_per_merchant
    
  end
end
