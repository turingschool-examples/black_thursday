require_relative 'sales_engine.rb'
require 'pry'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def group_items_by_merchant
    @sales_engine.items.all.group_by do |item|
      item.merchant_id
    end
  end

  def count_items_by_merchant
    group_items_by_merchant.values.map do |value|
      value.count
    end
  end

  def average_items_per_merchant
    sum = count_items_by_merchant.inject(0) do |sum, number|
      sum += number
    end
    (sum / group_items_by_merchant.keys.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    count_minus_one = count_items_by_merchant.count - 1
    sum = count_items_by_merchant.inject(0.0) do |total, amount|
      total + (amount - average_items_per_merchant) ** 2
    end
    ((sum / count_minus_one) ** (1.0/2)).round(2)
  end

  def merchants_with_high_item_count
    deviation = average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    high_count = deviation + average

    merchant_id_paired_with_count.map do |merchant, count|
      @sales_engine.merchants.find_by_id(merchant) if count >= high_count
    end.compact
  end

  def merchant_id_paired_with_count
    group_items_by_merchant.keys.zip(count_items_by_merchant)
  end
end
