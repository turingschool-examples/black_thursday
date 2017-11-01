require './lib/sales_engine'

class SalesAnalyst
  attr_reader :se

  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
    se.items.items.count / se.merchants.merchants.count
  end

  def average_items_per_merchant_standard_deviation
      Math.sqrt(count_all_items_for_each_merchant.map do |item_count|
        (average_items_per_merchant - item_count)**2
      end.sum / (se.merchants.merchants.count - 1))
  end

  def count_all_items_for_each_merchant
    se.merchants.merchants.map do |merchant|
      merchant.items.count
    end
  end

  def

  end
end
