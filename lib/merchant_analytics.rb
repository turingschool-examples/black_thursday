module MerchantAnalytics

  def total_revenue_by_date(date)

  end

  def find_all_invoices_by_date(date)
    @sales_engine.invoices.all.find_all do |invoice|
      invoice.created_at.strftime('%d%m%y') == date.strftime('%d%m%y')
    end
  end


end
