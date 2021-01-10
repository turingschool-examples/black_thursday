require_relative './sales_engine'
require_relative './item_repo'
require_relative './invoice_repo'
require_relative './merchant_repo'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def average_items_per_merchant
    (all_merchant_item_count.sum.to_f / all_merchant_item_count.size).round(2)
  end

  def all_merchant_item_count
    @sales_engine.merchants.all.map do |merchant|
      @sales_engine.merchant_items(merchant.id).length
    end
  end

  def find_mean_of_merchant_items(merchant_items)
    (merchant_items.inject(0) { |sum, x| sum += x } / merchant_items.size.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation(merchant_items)
    mean = find_mean_of_merchant_items(merchant_items)
    variance = merchant_items.inject(0) { |variance, x| variance += (x - mean) ** 2 }
    standard_deviation = Math.sqrt(variance/(merchant_items.size-1)).round(2)
  end
end