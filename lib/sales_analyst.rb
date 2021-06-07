require 'csv'
require_relative 'sales_engine'

class SalesAnalyst
  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
    (@se.item_repo_total_items.to_f / @se.item_repo_total_merchants).round(2)
  end
end
