class SalesAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    merchant_count = sales_engine.number_of_merchants
    item_count = sales_engine.number_of_items

    (item_count / merchant_count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant = sales_engine.number_of_items_per_merchant
    sum_of_means_squared = items_per_merchant.map do |number|
      (number - average_items_per_merchant)**2
    end
    Math.sqrt(sum_of_means_squared.reduce(:+) / (items_per_merchant.count - 1)).round(2)
  end

  def merchants_with_high_item_count

    total = average_items_per_merchant + average_items_per_merchant_standard_deviation
    high_sellers = []

    sales_engine.merchants.all.each do |merchant|
      if merchant.items.count >= total
        high_sellers << merchant
      end
    end
    high_sellers
  end

end
