module ItemAnalyst

  def items
    sales_engine.items.all
  end

  def average_price(items)
    set = items.map {|item| item.unit_price}
    average(set).round(2)
  end

  def golden_items
    threshold = golden_items_threshold
    items.find_all {|item| item.unit_price > threshold}
  end

  def golden_items_threshold
    average_item_price = average_price(items)
    set = items.map {|item| item.unit_price}
    standard_deviation = standard_deviation(set)
    average_item_price + standard_deviation * 2
  end

end