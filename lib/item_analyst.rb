module ItemAnalyst
  def average_items_per_merchant
    (item_count.to_f / merchant_count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average_items = average_items_per_merchant
    Math.sqrt(all_items_for_each_merchant.map do |(key, item_count)|
      (average_items - item_count) ** 2
    end.sum / (merchant_count - 1)).round(2)
  end

  def all_items_for_each_merchant
    se.items.items.reduce({}) do |result, item|
      result[item.merchant_id] = 0 if result[item.merchant_id].nil?
      result[item.merchant_id] += 1
      result
    end
  end

  def merchants_with_high_item_count
    minimum = minimum_for_high_items
    all_items_for_each_merchant.reduce([]) do |result, (merchant_id, items)|
      result << se.merchants.find_by_id(merchant_id) if items >= minimum
      result
    end
  end

  def minimum_for_high_items
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id.to_s)
    return 0 if merchant.items.count.zero?
    BigDecimal((merchant.items.inject(0) do |sum, item|
      sum += item.unit_price
    end/merchant.items.count)).round(2)
  end

  def average_average_price_per_merchant
    BigDecimal((se.merchants.merchants.inject(0) do |sum, merchant|
      sum += average_item_price_for_merchant(merchant.id)
    end/merchant_count)).round(2)
  end

  def standard_deviation_of_item_price
    average_price = average_item_price
    Math.sqrt(se.items.items.map do |item|
      (average_price - item.unit_price) ** 2
    end.sum / (item_count - 1)).round(2)
  end

  def average_item_price
    BigDecimal((se.items.items.inject(0) do |sum, item|
      sum += item.unit_price
    end/item_count).round)
  end

  def golden_items
    minimum = minimum_for_golden_item
    se.items.items.reduce([]) do |result, item|
      if item.unit_price >= minimum
        result << item
      end
      result
    end
  end

  def minimum_for_golden_item
    average_item_price + (2 * standard_deviation_of_item_price)
  end
end
