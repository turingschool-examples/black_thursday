require 'pry'
require_relative 'sales_engine'
class SalesAnalyst
  def initialize(se)
    @se = se
    @mr = @se.merchants
  end

  def average_items_per_merchant
    #can ask item repo for items.count and merch repo merchants.count
    merchant_ids = @mr.all.map { |merchant| merchant.id }
    total_items = merchant_ids.reduce(0) do |sum, id|
      sum += @mr.find_items(id).count
    end
    total_items/@mr.merchants.count.to_f
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    merchant_ids = @mr.all.map { |merchant| merchant.id }
    item_count = merchant_ids.map do |id|
      @mr.find_items(id).count
    end

    sum = item_count.reduce(0) do |sum, count|
      (count - average) ** 2
    end
    deviation = Math.sqrt(sum / 2)
    (deviation * 100).floor / 100.0
  end

end
