require_relative 'sales_engine'

class SalesAnalyst

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    (@se.items.items.count.to_f / @se.merchants.merchants.count.to_f).round(2)
  end

end