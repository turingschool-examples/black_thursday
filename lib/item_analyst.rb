module ItemAnalyst

  def average_items_per_merchant
    average(merchant_items_set)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(merchant_items_set)
  end

  def merchants_with_high_item_count
    merchants.select do |merchant|
      merchant.items.count > top_threshold(merchant_items_set, 1)
    end
  end

  def average_item_price_for_merchant(merch_id)
    items_by_merchant = engine.merchants.find_by_id(merch_id).items
    average(items_by_merchant.map { |item| item.unit_price })
  end

  def average_average_price_per_merchant
    total_avgs ||= merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end

    average(total_avgs)
  end

  def average_item_price
    average(price_set)
  end

  def item_price_standard_deviation
    standard_deviation(price_set)
  end

  def golden_items
    prices_top_threshold ||= top_threshold(price_set, 2)
    items.select do |item|
      item.unit_price_to_dollars > prices_top_threshold
    end
  end

  private

  def items
    engine.items.all
  end

end