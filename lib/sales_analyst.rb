class SalesAnalyst

  def initialize(items, merchants)
    @items              = items
    @merchants          = merchants
    @standard_deviation = average_item_per_merchant_standard_deviation
  end

  def average_item_per_merchant
    sum = items_per_merchant.sum 
    average = sum.to_f/@merchants.all.length
    average.round(2)
  end

  def items_per_merchant
    @merchants.all.map do |merchant|
      @items.find_all_by_merchant_id(merchant.id).length
    end
  end

  def average_item_per_merchant_standard_deviation
    sum = items_per_merchant.sum do |item_per_merchant|
      (item_per_merchant - average_item_per_merchant) ** 2 
    end 
    sum /= (@merchants.all.length - 1)
    Math.sqrt(sum).round(2)
  end

  def merchants_with_high_item_count 
    @merchants.all.find_all do |merchant|
      @items.find_all_by_merchant_id(merchant.id).length > @standard_deviation
    end 
  end 
end
