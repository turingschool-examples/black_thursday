module MerchantAnalysis

  def golden_items
    average = average_average_price_per_merchant
    se.items.all.find_all do |item|
      item.unit_price > average + (2 * standard_deviation(all_item_prices))
    end
  end

  def average_average_price_per_merchant
    average_prices = se.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    BigDecimal(average(average_prices), 6).floor(2)
  end

  def average_item_price_for_merchant(merchant_id)
    prices = se.merchants.find_by_id(merchant_id).items.map do |item|
      item.unit_price.to_f
    end
    BigDecimal(average(prices), 4)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(merchant_item_count)
  end

  def merchants_with_high_item_count
    standard_deviation = average_items_per_merchant_standard_deviation
    se.merchants.all.find_all do |merchant|
      merchant.items.count > average_items_per_merchant + standard_deviation
    end
  end

  def total_merchants
    se.merchants.all.count
  end

  def average_invoices_per_merchant
    average(all_merchants_invoices_count).round(2)
  end

  def all_merchants_invoices_count
    se.merchants.all.map do |merchant|
      merchant.invoices.count
    end
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(all_merchants_invoices_count)
  end

  def top_merchants_by_invoice_count
    average = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    se.merchants.all.find_all do |merchant|
      merchant.invoices.count > average + (2 * standard_deviation)
    end
  end

  def bottom_merchants_by_invoice_count
    average = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    se.merchants.all.find_all do |merchant|
      merchant.invoices.count < average - (2 * standard_deviation)
    end
  end

  def all_item_prices
    se.items.all.map do |item|
      item.unit_price
    end
  end

  def merchant_item_count
    se.merchants.all.map do |merchant|
      merchant.items.count
    end
  end

  def average_items_per_merchant
    (total_items.to_f / total_merchants).round(2)
  end

  def total_items
    se.items.all.count
  end

end
