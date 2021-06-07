require 'csv'
require_relative 'sales_engine'

class SalesAnalyst
  def initialize(sales_engine)
    @se = sales_engine
  end

  def total_revenue_by_date(date)
    @se.invoice_items.find_unit_price_by_date(date).sum do |invoice_items|
      invoice_items.unit_price
    end
  end
end
