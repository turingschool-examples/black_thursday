module MerchantAnalyst
  def add_items_and_std_deviation
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchants_ranked_by_revenue
    top_revenue_earners(merchants.length)
  end

  def merchants_ranked_by_revenue
    top_revenue_earners(merchants.length)
  end

  def merchants_by_month(month)
    merchants.select {|m| m.created_at.strftime("%B") == month.capitalize}
  end

  def id_and_total_quantity_of_item(merchant_id)
    inv = completed_invoices(engine.find_invoices_by_merchant_id(merchant_id))
    inv.flat_map(&:invoice_items).reduce({}) do |hash, inv_item|
      hash[inv_item.item_id]  = 0 if !hash[inv_item.item_id]
      hash[inv_item.item_id] += inv_item.quantity
      hash
    end
  end

  def pending?(invoice)
    invoice.transactions.all? { |t| t.result == "failed" }
  end

  def completed_invoices(invoices)
    invoices.reject {|invoice| pending?(invoice)}
  end

  def pending_invoices?(merchant)
    merchant.invoices.any? {|invoice| !invoice.is_paid_in_full?}
  end
end
