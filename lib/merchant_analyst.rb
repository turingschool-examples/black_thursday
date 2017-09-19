module MerchantAnalyst

  def calculate_total_revenue(invoice_list)
    invoice_list.reduce(0) do |total_revenue, invoice|
      total_revenue + invoice.total
    end
  end

  def total_revenue_by_date(date)
    invoices_by_date = @engine.invoices.find_all_by_date(date)
    calculate_total_revenue(invoices_by_date)
  end

  def revenue_per_merchant(merchant_id)
    merchant_invoices = @engine.invoices.find_all_by_merchant_id(merchant_id)
    merchant_invoice_revenues = merchant_invoices.map do |merchant_invoice|
      merchant_invoice.total
    end
    merchant_invoice_revenues.compact.sum
  end

  def total_revenue_for_all_merchants
    revenue_per_invoice = Hash[@engine.invoice_list.map {|invoice| [invoice.merchant_id, revenue_per_merchant(invoice.merchant_id)]}]
  end

  def top_revenue_earners(x)
    all_earners_sorted = total_revenue_for_all_merchants.sort_by {|key, value| value}.to_h
    top_x_earner_ids = all_earners_sorted.keys[-x..-1]
    top_x_earner_ids.map {|earner_id| @engine.merchants.find_by_id(earner_id)}
  end

end
