class SalesAnalyst
  def initialize(sales_engine)
    @engine = sales_engine
  end

  def average_items_per_merchant
    items = @engine.items.elements.count.to_f
    merchants = @engine.merchants.elements.count.to_f
    (items / merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchants = @engine.merchants.elements
    items = @engine.items
    average = average_items_per_merchant
    deviation_sum = 0
    merchants.keys.each do |merchant_id|
      item_count = items.find_all_by_merchant_id(merchant_id).count
      deviation_sum += (item_count.to_f - average).abs ** 2
    end
    # binding.pry
    divided_deviation = deviation_sum / (merchants.count - 1)
    Math.sqrt(divided_deviation).round(2)
  end

end
