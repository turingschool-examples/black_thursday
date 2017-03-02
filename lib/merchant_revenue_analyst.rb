module MerchantRevenueAnalyst

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

  def merchants_with_highest_revenue
    highest_merchs ||= merchants_ranked_by_revenue[0..4]
  end

  private

  def paid_merchant_invoices(merchant_id)
    merchant = engine.merchants.find_by_id(merchant_id)
    merchant.invoices.map do |invoice|
      invoice.invoice_items if invoice.is_paid_in_full?
    end.flatten.compact
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