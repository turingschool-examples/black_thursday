module MerchantAnalytics
 def paid_invoices_by_date(date)
   @sales_engine.invoices.all.map do |invoice|
     if invoice_paid_in_full?(invoice.id) && invoice.created_at == date
       invoice
     end
   end.compact
 end

  def total_revenue_by_date(date)
    revenues_by_date = paid_invoices_by_date(date).map do |invoice|
      invoice_total(invoice.id)
    end
    sum(revenues_by_date)
  end
end
