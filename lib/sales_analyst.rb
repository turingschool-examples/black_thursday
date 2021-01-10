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

  def average_items_per_merchant_standard_deviation(merchant_items)
    mean = average_items_per_merchant
    variance = merchant_items.inject(0) do |variance, item_count|
      variance += (item_count - mean) ** 2 
    end
    Math.sqrt(variance / (merchant_items.size - 1)).round(2)
  end
end