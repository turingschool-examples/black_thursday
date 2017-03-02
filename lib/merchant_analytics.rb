require_relative 'sales_analyst'
require_relative 'sales_engine'

module MerchantAnalytics

  def total_revenue_by_date(date)
    invoice_date = sales_analyst.sales_engine.invoices.find_all_by_date(date)
    invoice_date.reduce(0) { |sum, invoice| sum + invoice.total }
  end

end
