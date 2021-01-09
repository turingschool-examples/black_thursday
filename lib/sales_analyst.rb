require 'pry'

class SalesAnalyst
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (total_items.to_f / total_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    total = 0
    merchant_item_count.each do |key, value|
      total += (average - value)**2
    end
    Math.sqrt(total/(total_merchants - 1)).round(2)
  end

  def merchants_with_high_item_count
    greater_than_sd = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchants = []
    merchant_item_count.find_all do |merchant_id, count|
      if count >= greater_than_sd
        merchants << @sales_engine.merchants.find_by_id(merchant_id)
      end
    end
    merchants
  end

  def average_item_price_for_merchant(merchant_id)
    items = @sales_engine.items.find_all_by_merchant_id(merchant_id)
    price_total = 0
    items.each do |item|
     price_total += item.unit_price
   end
    (price_total / items.count).round(2)
  end

  def merchant_item_count
    sales_engine.items.all.reduce({}) do |acc, item|
      merchant_item_count = sales_engine.items.find_all_by_merchant_id(item.merchant_id).length
      acc[item.merchant_id] = merchant_item_count
      acc
    end
  end

  def total_items
    sales_engine.items.all.length
  end

  def total_merchants
    sales_engine.merchants.all.length
  end

end
