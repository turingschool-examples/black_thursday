require 'csv'
require_relative 'sales_engine'

class SalesAnalyst
  def initialize(sales_engine)
    @se = sales_engine
  end

  def total_revenue_by_date(date)
    @se.invoice_items_by_date(date)[date].sum
  end

  def top_revenue_earners(number)
    # top_earners = []
    top_earners = @se.price_by_merchant.max_by(number) do |merchant, unit_price|
      unit_price
    end.flat_map do |earner_pair|
      earner_pair.first
    end
  end
end
