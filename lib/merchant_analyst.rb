module MerchantAnalyst

  def average_invoices_per_merchant
    average(invoice_set)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoice_set)
  end

  def top_merchants_by_invoice_count
    top_threshold_invoices ||= top_threshold(invoice_set, 2)
    merchants.select do |merchant|
      merchant.invoices.count > top_threshold_invoices
    end
  end

  def bottom_merchants_by_invoice_count
    bottom_threshold_invoices ||= bottom_threshold(invoice_set, 2)
    merchants.select do |merchant|
      merchant.invoices.count < bottom_threshold_invoices
    end
  end

  def revenue_by_merchant(merch_id)
    engine.merchants.find_by_id(merch_id).revenue
  end

  def merchants_ranked_by_revenue
    merchants_by_revenue ||= merchants.sort_by do |merchant|
      [merchant.revenue ? 1 : 0, merchant.revenue]
    end.reverse
  end

  def top_revenue_earners(num_top = 20)
    merchants_ranked_by_revenue[0..num_top-1]
  end

  def merchants_with_pending_invoices
    merchants_pending ||= merchants.select do |merchant|
      merchant.any_pending?
    end
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

  def merchants_with_highest_revenue
    highest_merchs ||= merchants_ranked_by_revenue[0..4]
  end

  private

  def merchants
    engine.merchants.all
  end

  def paid_merchant_invoices(merchant_id)
    merchant = engine.merchants.find_by_id(merchant_id)
    merchant.invoices.map do |invoice|
      invoice.invoice_items if invoice.is_paid_in_full?
    end.flatten.compact
  end

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

  def item_revenue_for_merchant(merchant_id)
    paid_merchant_invoices(merchant_id).reduce({}) do |memo, invoice_item|
      memo[invoice_item] = invoice_item.quantity * invoice_item.unit_price
      memo
    end
  end

  def revenue_sorted(merchant_id)
    rs=item_revenue_for_merchant(merchant_id).max_by do |invoice_item, revenue|
      revenue
    end
    rs.pop
    rs
  end

end