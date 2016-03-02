require_relative 'sales_engine'
require 'csv'
require 'pry'

class SalesAnalyst
  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    (@se.items.repository.count.to_f/@se.merchants.repository.count.to_f).round(2)
  end

  def items_per_merchant_hash
    @se.items.repository.group_by { |item| item.merchant_id }
  end

  def item_count_per_merchant_hash
    items_per_merchant_hash.map {|merchant_id, items| [merchant_id, items.count] }.to_h
  end

  def average_items_per_merchant_standard_deviation
    n = item_count_per_merchant_hash.values.map do |value|
      (value - average_items_per_merchant)**2
    end.reduce(:+)/(@se.merchants.repository.count.to_f - 1)
    
    Math.sqrt(n).round(2)
  end

end
