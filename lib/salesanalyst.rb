class SalesAnalyst
  def initialize(merchants,items)
    @merchants = merchants
    @items = items
  end

  def average_items_per_merchant
    (@items.all.count / @merchants.all.count.to_f).round(2)
  end
end