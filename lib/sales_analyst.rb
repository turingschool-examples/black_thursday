class SalesAnalyst
  attr_reader :items,
              :merchants

  def initialize(items, merchants)
    @items ||= items
    @merchants ||= merchants
  end

  def average_items_per_merchant
    (@items.all.length.to_f/@merchants.all.length).round(2)
  end

  
end
