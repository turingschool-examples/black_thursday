module ItemAnalyst
  def all_items_for_each_merchant
    accumulate_merchant_items.flat_map do |merchant_items|
      merchant_items[1]
    end
  end

  def accumulate_merchant_items
    se.items.items.reduce({}) do |result, item|
      result[item.merchant_id] = 0 if result[item.merchant_id].nil?
      result[item.merchant_id] += 1
      result
    end
  end

  def minimum_for_high_items
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def standard_deviation_of_item_price_standard
    standard_deviation(
      all_item_prices,
      total_all_item_prices,
      item_count
    )
  end

  def all_item_prices
    se.items.items.map do |item|
      item.unit_price
    end
  end

  def total_all_item_prices
    se.items.items.inject(0) do |sum, item|
      sum += item.unit_price
    end
  end

  def average_item_price
    averager(total_all_item_prices, item_count)
  end

  # def average_item_price
  #   BigDecimal((se.items.items.inject(0) do |sum, item|
  #     sum += item.unit_price
  #   end/item_count).round)
  # end

  def minimum_for_golden_item
    average_item_price + (2 * standard_deviation_of_item_price)
  end
end
