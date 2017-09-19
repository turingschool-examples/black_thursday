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

  def top_revenue_earners(x)
    revenue_per_invoice = @engine.invoice_list.map do |invoice|
      invoice.total
  end
end
