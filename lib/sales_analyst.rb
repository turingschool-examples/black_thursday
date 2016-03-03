require_relative '../lib/sales_engine'
require 'csv'
require 'pry'
require 'bigdecimal'

class SalesAnalyst
  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
     (@se.items.repository.count.to_f/@se.merchants.repository.count.to_f).round(2)
  end

  def items_per_merchant_hash #need test?
    @se.items.repository.group_by { |item| item.merchant_id }
  end

  def item_count_per_merchant_hash # need test?
    items_per_merchant_hash.map { |merchant_id, items| [merchant_id, items.count] }.to_h
  end

  def average_items_per_merchant_standard_deviation
    n = item_count_per_merchant_hash.values.map do |value|
          (value - average_items_per_merchant)**2
        end.reduce(:+)/(@se.merchants.repository.count.to_f - 1)

    Math.sqrt(n).round(2)
  end

  def one_std_dev
    average_items_per_merchant_standard_deviation + average_items_per_merchant
  end

  def two_std_dev
    ((average_items_per_merchant_standard_deviation * 2) + average_items_per_merchant).round(2)
  end

  def merchants_with_high_item_count
    item_count_per_merchant_hash.find_all do |merchant_id, item_count|
        merchant_id if item_count > one_std_dev
      end.map do |element|
        @se.merchants.find_by_id(element[0])
      end
  end

  def average_item_price_for_merchant(merchant_id)
    x = items_per_merchant_hash
    n = BigDecimal.new(x[merchant_id].reduce(0) do |sum, item|
      sum += item.unit_price.to_i
    end/x.count)
  end

  def average_average_price_per_merchant
    x = items_per_merchant_hash
    BigDecimal.new(x.map do |merchant, items|
      average_item_price_for_merchant(merchant)
    end.reduce(:+)/x.count)
  end
end
