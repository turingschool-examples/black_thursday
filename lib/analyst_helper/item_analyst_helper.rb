module ItemAnalyst

  def number_of_items_per_merchant
    @all_items_per_merchant.values.map(&:count)
  end

  def average_items_per_merchant
    item_count = @all_items_per_merchant.values.map(&:count)
    item_sum = find_sum(item_count)
    (item_sum.to_f / @all_items_per_merchant.values.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(number_of_items_per_merchant).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    item_prices = @all_items_per_merchant[merchant_id].map(&:unit_price)
    BigDecimal((find_sum(item_prices)/item_prices.count)).round(2)
  end

  def golden_items
    std_dev = standard_deviation(@sales_engine.all_item_prices_per_item.values)
    mean = find_mean(@sales_engine.all_item_prices_per_item.values)
    high_price_items = []
    @sales_engine.all_item_prices_per_item.each_pair do |item, price|
      if std_dev_above_mean(price, mean, std_dev) >= 2
        high_price_items << item
      end
    end
    high_price_items
  end
end
