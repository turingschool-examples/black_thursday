class SalesAnalyst 
  attr_reader :items,
              :merchants


  def initialize(items, merchants) 
    @items = items
    @merchants = merchants
  end

  def average_items_per_merchant 
    (@items.all.size.to_f / @merchants.all.size).round(2)
  end

end