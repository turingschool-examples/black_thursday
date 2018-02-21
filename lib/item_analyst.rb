module ItemAnalyst
  def average_item_price
    (@items.all.reduce(0) do |result,item|
      result += item.unit_price
    end/total_items).round(2)
  end

  def item_std_dev
    Math.sqrt(item_std_dev_calculate_sum / (total_items-1)).round(2)
  end

  def item_std_dev_calculate_sum
    average_price = average_item_price
    @items.all.reduce(0) {|result, item|
      squared_difference = (average_price - item.unit_price) ** 2
      result + squared_difference}
  end

  def golden_items
    @items.all.map do |item|
      item if item.unit_price > (average_item_price + (item_std_dev*2))
    end.compact
  end
end
