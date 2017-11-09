module ItemAnalytics

  def find_items
    merchant_list.map do |merchant|
      sales_engine.items.find_all_by_merchant_id(merchant).count
    end
  end

  def average_unit_price
    (@sales_engine.items.all.reduce(0) { |sum, item|
    sum + item.unit_price
     } / @sales_engine.items.all.count).round(2).to_f
  end

  def unit_price_and_average_diff_sq_sum
    @sales_engine.items.all.reduce(0) { |sum, item|
    sum += (item.unit_price - average_unit_price) ** 2 }
  end

  def unit_price_squared_sum_division
    unit_price_and_average_diff_sq_sum / ((@sales_engine.items.all.count) - 1)
  end

  def unit_price_standard_deviation
    Math.sqrt(unit_price_squared_sum_division).round(2)
  end

  def golden_items_deviation
    (average_unit_price + (unit_price_standard_deviation * 2))
  end

  def golden_items
    @sales_engine.items.items.find_all do |item|
      item if item.unit_price >= @golden_items_dev
     end
  end

  def most_frequent_item_on_list(id)
    max = frequency_list_for_items(id).values.max
    frequency_list_for_items(id).select { |key, value|
        value == max }.to_a
  end
end
