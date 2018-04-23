module MerchantAnalyst
  def items_per_merchant
    merchants.merchants.map do |merchant|
      id = merchant.id
      @sales_engine.items.find_all_by_merchant_id(id).length
    end
  end

  def average_items_per_merchant
    num_per_merchant = items_per_merchant
    sum = num_per_merchant.inject(:+).to_f
    ((sum / num_per_merchant.length.to_f)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items = items_per_merchant
    average = average_items_per_merchant
    standard_deviation(items, average)
  end

  def merchants_with_high_item_count
    items = items_per_merchant
    average = average_items_per_merchant
    std = standard_deviation(items, average)
    merchants.all.find_all do |merchant|
      merchant.items.count > (average + std)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = merchants.find_by_id(merchant_id)
    item_prices = merchant.items.map do |item|
      item.unit_price
    end
    average(item_prices).round(2)
  end

  def average_average_price_per_merchant
    merchants_average = merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average(merchants_average).round(2)
  end
end
