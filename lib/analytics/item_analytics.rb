# Module to contain analytic methods for items
module ItemAnalytics
  def average_item_price
    total_items = @item_repo.all.count
    all_item_prices = @item_repo.all.map(&:unit_price)
    average(all_item_prices.inject(:+), total_items)
  end

  def average_item_price_standard_deviation
    standard_deviation(@item_repo.items.values.map(&:unit_price).sort, average_item_price)
  end

  def golden_items
    threshold = average_item_price + (average_item_price_standard_deviation * 2)
    @item_repo.all.map do |item|
      require 'pry';binding.pry
      item if item.unit_price >= threshold
    end.compact
  end

  def items_bought_in_year(customer_id, year)
    # invoices = @invoice_repo.all
    # by_customer = invoices.find_all do |invoice|
    #   invoice.customer_id == customer_id
    # end
    # by_year = by_customer.find_all do |invoice|
    #   invoice.created_at.year == year
    # end
    # items = by_year.map do |invoice|
    #   require 'pry';binding.pry
    #   id = @invoice_item_repo.find_by_id(invoice.id).item_id
    #   @item_repo.find_by_id(item_id)
    # end
  end
end
