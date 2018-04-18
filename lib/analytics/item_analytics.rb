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

  def invoice_item_quantities(customer_id)
    invoices = invoices_per_customer[customer_id]
    all_invoice_items = invoices.flat_map do |invoice|
      @invoice_item_repo.find_all_by_invoice_id(invoice.id)
    end
    invoice_items_by_item_id = all_invoice_items.group_by(&:item_id)
    sum_quantities = {}
    invoice_items_by_item_id.each do |item_id, invoice_items|
      sum_quantities[item_id] = invoice_items.reduce(0) do |sum, invoice_item|
        sum + invoice_item.quantity
      end
    end
    sum_quantities
  end

  def highest_volume_items(customer_id)
    quantities = invoice_item_quantities(customer_id)
    max = quantities.values.max
    by_count = {}
    quantities.each do |item_id, count|
      by_count[count] ? by_count[count] << item_id : by_count[count] = [] << item_id
    end
    by_count[max].map do |item_id|
      @item_repo.find_by_id(item_id)
    end
  end
end
