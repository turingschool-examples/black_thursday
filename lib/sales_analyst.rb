require 'csv'
require_relative 'sales_engine'

class SalesAnalyst
  def initialize(sales_engine)
    @se = sales_engine
  end

  def total_revenue_by_date(date)
    @se.unit_price_by_date(date)[date].sum
  end
end
