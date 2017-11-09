module BusinessIntelligence

  def find_standard_deviation_difference_total
    find_items.map do |item_total|
      (item_total - average_items_per_merchant) ** 2
    end.sum.round(2)
  end

  def find_standard_deviation_total
    find_standard_deviation_difference_total / total_merchants_minus_one
  end

  def invoice_total_minus_average_squared
    find_invoice_totals.reduce(0) { |sum, total|
    sum += (total - @ave_inv_per_merch) ** 2 }
  end

  def invoice_difference_total_divided
    (invoice_total_minus_average_squared / (find_invoice_totals.length - 1))
  end


  def map_created_dates_to_weekdays
    @sales_engine.invoices.invoices.map do |invoice|
      invoice.created_at.strftime("%A")
    end
  end

  def invoice_totals_by_day
    map_created_dates_to_weekdays.each_with_object(Hash.new(0)) do
      |word, acc| acc[word] += 1
    end
  end

  def invoice_per_day_average
    invoice_totals_by_day.reduce(0) { |sum, (key, value) |
      sum += value } / invoice_totals_by_day.count
  end

  def invoice_totals_minus_average_squared
    invoice_totals_by_day.reduce(0) { |sum, (key, value) |
      sum += (value - invoice_per_day_average) ** 2 }
  end

  def weekday_invoice_total_difference_divided
    invoice_totals_minus_average_squared / ((invoice_totals_by_day.count) - 1)
  end

  def weekday_invoice_creation_standard_deviation
    Math.sqrt(weekday_invoice_total_difference_divided).round(2)
  end

  def invoice_creation_standard_deviation_plus_average
    weekday_invoice_creation_standard_deviation + invoice_per_day_average
  end

  def top_days_by_invoice_count
    invoice_totals_by_day.select do |key, value|
      value >= invoice_creation_standard_deviation_plus_average
    end.keys
  end

  def invoice_status(status)
    (find_all_invoices(status).length /
    sales_engine.invoices.all.length.to_f * 100).round(2)
  end

  def find_all_invoices(status)
    sales_engine.invoices.find_all_by_status(status)
  end

  def find_all_invoices_by_date(date)
    sales_engine.invoices.find_all_by_created_date(date)
  end

  def filter_valid_invoices(invoices)
    invoices.reduce([]) do |result, invoice|
      result << invoice if invoice.is_paid_in_full? == true
    end
  end

  def find_invoice_items_for_invoice_collection(invoices)
    invoices.reduce([]) do |result, invoice|
      result << invoice.invoice_items
    end.flatten
  end

  def total_invoice_items_price(invoice_items)
    invoice_items.reduce(0) do |total, invoice_item|
      total += (invoice_item.quantity * invoice_item.unit_price)
    end
  end

  def total_revenue_by_date(date)
    invoices = find_all_invoices_by_date(date)
    filtered_invoices = filter_valid_invoices(invoices)
    invoice_items = find_invoice_items_for_invoice_collection(invoices)
    total_invoice_items_price(invoice_items)
  end

  def unit_price_to_dollars(unit_price)
    (BigDecimal.new(unit_price)/100).round(2).to_f
  end

  def valid_invoices
    @sales_engine.invoices.all.find_all do |invoice|
      invoice.is_paid_in_full?
    end
  end

  def invalid_invoices
    @sales_engine.invoices.all.find_all do |invoice|
      invoice.is_paid_in_full? == false
    end
  end

  def invoice_totals(invoices)
    invoices.reduce(0) do |sum, invoice|
      sum += invoice.total
    end
  end
end
