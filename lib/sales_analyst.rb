
class SalesAnalyst
  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    ((@se.item.all.count.to_f) / (@se.merchant.all.count.to_f)).round(2)
  end

  
end
