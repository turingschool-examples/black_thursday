# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'


class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    merchant_count = @engine.merchants.all.size.to_f
    item_count = @engine.items.all.size.to_f
    BigDecimal((item_count / merchant_count), 3)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    all_merchants = @engine.merchants.all

    items_per_merchant = []
    all_merchants.each do |merchant|
      items_per_merchant << @engine.items.find_all_by_merchant_id(merchant.id).size
    end
    equation = items_per_merchant.inject(0) do |sum, number_items|
      sum + (number_items - average)**2
    end
    ((Math.sqrt(equation / (items_per_merchant.size - 1)).round(2))).to_d
  end

  def merchants_with_high_item_count
    std = average_items_per_merchant + average_items_per_merchant_standard_deviation
    all_merchants = @engine.merchants.all

    all_merchants.find_all do |merchant|
      @engine.items.find_all_by_merchant_id(merchant.id).size > std
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @engine.merchants.find_by_id(merchant_id)
    total_items = @engine.items.find_all_by_merchant_id(merchant_id).size
    all_items = @engine.items.find_all_by_merchant_id(merchant_id)
    sum = all_items.inject(0) do |sum, item|
      sum + item.unit_price
    end
    average_price = sum / total_items
    BigDecimal(average_price, 5)
  end

  def average_item_price_per_merchant

    # iterate - perform the above methos on all merchants
    # sum total / divid by total number of merchants
    #return big decimal
  end

  def golden_items
    #run above method to get the average item price for all merchants
    #see above
  end
end
