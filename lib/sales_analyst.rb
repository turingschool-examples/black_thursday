require './lib/sales_engine'

class SalesAnalyst
  attr_reader :se

  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
    se.items.items.count / se.merchants.merchants.count
  end

  def standard_deviation_items_per_merchant
      Math.sqrt(count_all_items_for_each_merchant.map do |item_count|
        (average_items_per_merchant - item_count)**2
      end.sum / (se.merchants.merchants.count - 1))
  end

  def count_all_items_for_each_merchant
    se.merchants.merchants.map do |merchant|
      merchant.items.count
    end
  end

  def merchants_with_high_item_count
    se.merchants.merchants.reduce([]) do |result, merchant|
      if merchant.items.count >= minimum_for_high_items
        result << merchant
       end
       result
    end
  end

  def minimum_for_high_items
    average_items_per_merchant + standard_deviation_items_per_merchant
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id.to_s)
    return 0 if merchant.items.count.zero?
    merchant.items.inject(0) do |sum, item|
      sum += item.unit_price
    end/merchant.items.count
  end

  def average_average_price_per_merchant
    se.merchants.merchants.inject(0) do |sum, merchant|
      sum += average_item_price_for_merchant(merchant.id)
    end/se.merchants.merchants.count
  end
end
