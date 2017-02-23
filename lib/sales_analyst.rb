require_relative './sales_engine'
class SalesAnalyst
  attr_reader :engine
  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    @average = (engine.items.all.count.to_f / engine.merchants.all.count.to_f).round(2)
  end

  def merchant_item_count
    engine.merchants.all.map do |merchant|
      merchant.items.count
    end
  end

  def average_items_per_merchant_standard_deviation
    sum = merchant_item_count.inject(0) do |total, count|
      total + (count - average_items_per_merchant)**2
    end
    @sd = Math.sqrt(sum / (merchant_item_count.count - 1)).round(2)
  end

  def merchants_with_high_item_count
    average_items_per_merchant
    average_items_per_merchant_standard_deviation
    merchant_item_count.find_all do |count|
      count > @average + @sd
    end
  end
end
