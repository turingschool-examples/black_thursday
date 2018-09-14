 require 'bigdecimal'
require_relative '../lib/sales_engine'
require_relative '../lib/black_thursday_helper'
require_relative '../lib/sales_analyst_deviation_helper'
require 'pry'

class SalesAnalyst
  include BlackThursdayHelper
  include SalesAnalystHelper

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    total_merchants = @sales_engine.merchants.all.count
    total_items = @sales_engine.items.all.count
    BigDecimal((total_merchants.to_f/total_items),3)
  end

  def average_items_per_merchant_standard_deviation
    mean = mean_method
    items_per_merchant = all_merchants.map do |merchant|
      @sales_engine.items.find_all_by_merchant_id(merchant.id).size
    end

    standard_dev(items_per_merchant, mean)
  end

  def merchants_with_high_item_count
    goal = average_items_per_merchant + average_items_per_merchant_standard_deviation

    all_merchants.find_all do |merchant|
      @sales_engine.items.find_all_by_merchant_id(merchant.id).size > goal
    end
  end

  def average_item_price_per_merchant(merchant_id)
    items = @sales_engine.items.find_all_by_merchant_id(merchant_id)
    item_sum = items.inject(0) do |sum, item|
      sum + item.unit_price
    end
    average_price = item_sum/(items.count)
    BigDecimal(average_price, 4).round(2)
  end

  def average_average_price_per_merchant
    merchant_item_averages = all_merchants.map do |merchant|
      average_item_price_per_merchant(merchant.id)
    end
    averages_summed = merchant_item_averages.inject(0) do |sum, average|
      sum + average
    end
    averages_total = (averages_summed/ merchant_item_averages.size).round(2)
    BigDecimal(averages_total, 4)
  end

end
