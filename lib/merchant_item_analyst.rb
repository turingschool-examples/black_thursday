module MerchantItemAnalyst

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

  def merchants_with_only_one_item
    merchants_one_item ||= merchants.select do |merchant|
      merchant.only_one_item?
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.select do |merchant|
      merchant.created_at.strftime("%B") == month
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    top = quantity_of_item(merchant_id).select do |item_id, quantity|
      quantity == quantity_sorted(merchant_id)[1]
    end
    top.keys.map{|item| engine.items.find_by_id(item.item_id)}
  end

  def best_item_for_merchant(merchant_id)
    revenue_sorted(merchant_id).map do |item|
      engine.items.find_by_id(item.item_id)
    end.first
  end

  private

  def quantity_of_item(merchant_id)
    paid_merchant_invoices(merchant_id).reduce({}) do |memo, invoice_item|
      memo[invoice_item] = invoice_item.quantity
      memo
    end
  end

  def quantity_sorted(merchant_id)
    quantity_of_item(merchant_id).max_by do |invoice_item, quantity|
      quantity
    end
  end

end