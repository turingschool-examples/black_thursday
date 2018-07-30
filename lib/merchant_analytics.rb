module MerchantAnalytics

  def total_revenue_by_date(date)
    invoices = find_all_invoices_by_date(date)
    invoices.inject(0) do |total, invoice|
      total + invoice_total(invoice.id) if invoice_paid_in_full?(invoice.id)
    end
  end

  def find_all_invoices_by_date(date)
    @sales_engine.invoices.all.find_all do |invoice|
      invoice.created_at.strftime('%d%m%y') == date.strftime('%d%m%y')
    end
  end

  def top_revenue_earners(number)

  end

  def get_invoice_ids
    @sales_engine.invoice_items.all.map do |invoice_item|
      invoice_item.invoice_id
    end.uniq
  end

end
