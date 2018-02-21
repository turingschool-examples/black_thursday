#Business metadata calculator
class SalesAnalyst
  def initialize(sales_eng)
    @se = sales_eng
  end

  def average_items_per_merchant
    (@se.items.all.length.to_f / @se.merchants.all.length).round(2)
  end
end
