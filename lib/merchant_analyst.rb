module MerchantAnalyst

  def merchants
    sales_engine.merchants.all
  end

  def item_count(merchant)
    merchant.items.length
  end

  def merchant_item_counts
    merchants.map {|merchant| BigDecimal(item_count(merchant))}
  end

  def average_items_per_merchant
    average(merchant_item_counts).round(2).to_f
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(merchant_item_counts).round(2).to_f
  end

  def merchants_with_high_item_count
    standard_deviation = average_items_per_merchant_standard_deviation
    threshold = average_items_per_merchant + standard_deviation
    merchants.find_all {|merchant| item_count(merchant) > threshold}
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    set = merchant.items.map {|item| item.unit_price}
    average(set).round(2)
  end

  def average_average_price_per_merchant
    set = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average(set).round(2)
  end

end


