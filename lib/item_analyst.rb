# frozen_string_literal: true

# Item analyst
module ItemAnalyst
  def golden_items
    items_price = items.all.map(&:unit_price)
    average = average(items_price)
    std = standard_deviation(items_price, average)
    golden_items = items.all.find_all do |item|
      by_deviation(item.unit_price, average, std, 2)
    end
    golden_items.sort_by(&:unit_price).reverse
  end
end
