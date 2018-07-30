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
  def invoice_hash
    earners = {}
    group_invoices_by_merchant.each do |merchant_id, invoices|
      earners[merchant_id] = invoices.map do |invoice|
        invoice_total(invoice.id) if invoice_paid_in_full?(invoice.id)
      end.compact
    end
    earners
  end

  def sum_invoice_totals
    totals = {}
    invoice_hash.each do |merchant_id, invoices|
      totals[merchant_id] = invoices.inject(0) do |sum, invoice|
        sum + invoice
      end
    end
    totals.delete_if {|merchant_id, sum| sum == 0}
  end

  def sort_summed_invoice_totals
    sum_invoice_totals.sort_by {|merchant_id, sum| sum }.reverse.to_h
  end

end
