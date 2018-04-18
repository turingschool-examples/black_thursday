# Module to contain analytic methods for items
module ItemAnalytics
  def average_item_price
    total_items = @item_repo.all.count
    all_item_prices = @item_repo.all.map(&:unit_price)
    average(all_item_prices.inject(:+), total_items)
  end

  def average_item_price_standard_deviation
    sorted_unit_prices = @item_repo.items.values.map(&:unit_price).sort
    standard_deviation(sorted_unit_prices, average_item_price)
  end

  def golden_items
    threshold = average_item_price + (average_item_price_standard_deviation * 2)
    @item_repo.all.map do |item|
      item if item.unit_price >= threshold
    end.compact
  end

  def items_bought_in_year(customer_id, year)
    by_customer = @invoice_repo.find_all_by_customer_id(customer_id)
    by_year = by_customer.find_all do |invoice|
      invoice.created_at.year == year
    end
    invoice_items = by_year.flat_map do |invoice|
      @invoice_item_repo.find_all_by_invoice_id(invoice.id)
    end
    invoice_items.map do |invoice_item|
      @item_repo.find_by_id(invoice_item.item_id)
    end
  end
end
