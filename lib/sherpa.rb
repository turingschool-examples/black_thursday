module Sherpa

  def merchant_stock
    @se.items.all.group_by do |item|
      item.merchant_id
    end
  end

  def total_inventory
    merchant_stock.map do |merchant, items|
      [items.count.to_d]
    end
  end

  def prices
    @se.items.all.map { |item| item.unit_price }
  end

  def average_price_per_merchant
    merchant_ids = @se.merchants.all.map { |merchant| merchant.id }
    merchant_ids.map { |id| average_item_price_for_merchant(id) }
  end

  def price_standard_deviation
     standard_deviation(prices)
  end

  def invoice_stock
    @se.invoices.all.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def days_array
    ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  end

  def average_invoices_per_day
    total_invoices = @se.invoices.all.count.to_f
    total_days = 7.0
    (total_invoices / total_days).round(2)
  end

  def average_invoices_per_day_standard_deviation
    array = average_days_occurrence
    average = average_invoices_per_day
    differences = differences_from_average(array, average)
    squares = square_each_amount(differences)
    sum = sum_amount(squares)
    result = sum / 6.0
    Math.sqrt(result).round(2)
  end

  def average_days_occurrence
    days_array.map do |day|
      occurrences = @se.invoices.find_all_by_day(day)
      occurrences.count
    end
  end

  def average_days
    days = average_days_occurrence.inject(0) do |sum, num|
      sum += num
    end
      (days / 7.0).round(2)
  end

  def pending_invoices
    @se.invoices.all.map do |invoice|
      if !invoice_paid_in_full?(invoice.id)
       invoice
      end
    end.compact
  end

  def merchants_ranked_by_revenue
      merchant_revenue_array = @se.merchants.all.map do |merchant|
        [merchant, revenue_by_merchant(merchant.id)]
      end
      sorted_by_revenue = merchant_revenue_array.sort_by do |merchant, revenue|
        revenue
      end
      biggest_to_smallest = sorted_by_revenue.reverse
      biggest_to_smallest.map do |merchant, revenue|
        merchant
      end
  end

  def valid_transactions(invoices)
   invoices.find_all do |invoice|
     invoice_paid_in_full?(invoice.id)
   end
  end

  def valid_invoice_items(valid_transactions)
   valid_transactions.map do |invoice|
     @se.invoice_items.find_all_by_invoice_id(invoice.id)
   end.flatten
  end

  def quantity_of_items(grouped_items)
   grouped_items.map do |item_id, invoice_items|
     [item_id, invoice_items.inject(0) do |sum, invoice_item|
       sum + (invoice_item.quantity * invoice_item.unit_price)
     end ]
   end
  end

  def quantities_of_items(grouped_items)
   grouped_items.map do |item_id, invoice_items|
     [item_id, invoice_items.inject(0) { |sum, item| sum + item.quantity }]
   end
  end

  def get_quantity_of_items(qty)
   qty.map do |item_id, quantity|
     if quantity == qty[-1][1]
       @se.items.find_by_id(item_id)
     end
   end
  end

  def group_valid_invoice_items(valid_invoice_items)
   valid_invoice_items.group_by do |invoice_item|
     invoice_item.item_id
   end
  end

end
