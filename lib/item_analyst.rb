module ItemAnalyst

  def average_item_price
    average(price_set)
  end

  def item_price_standard_deviation
    standard_deviation(price_set)
  end

  def golden_items
    prices_top_threshold ||= top_threshold(price_set, 2)
    items.select do |item|
      item.unit_price_to_dollars > prices_top_threshold
    end
  end

  def golden_items_sorted
    sorted ||= golden_items.sort_by {|item| item.unit_price}.reverse
  end

  private

  def items
    engine.items.all
  end

  def price_set
    price_set ||= items.map { |item| item.unit_price_to_dollars}
  end

end