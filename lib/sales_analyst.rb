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

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    sum = array_of_items_per_merchant.sum(0.0) { |element| (element - mean) ** 2 }
    variance = sum / (@items.all.size)
    return Math.sqrt(variance).round(2)
  end

  def array_of_items_per_merchant 
    @merchants.map do |merchant|
      @items.find_all_by_merchant_id(merchant.id).size
    end
  end

end