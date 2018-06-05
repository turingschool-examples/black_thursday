module BusinessIntelligence
  def average_items_per_merchant
    total_items = items_per_merchant.inject(0.0) do |sum, item_count|
      sum += item_count
    end
    (total_items / items_per_merchant.count).round(2)
  end

  def items_per_merchant
    items_by_merchant_id.map { |_merchant_id, items| items.count }
  end

  def items_by_merchant_id
    @parent.items.all.group_by { |item| item.merchant_id }
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    sum_of_squares = items_per_merchant.inject(0.0) do |sum, items|
      ((items - mean)**2) + sum
    end / (items_per_merchant.count - 1)
    Math.sqrt(sum_of_squares).round(2)
  end

  def merchants_with_high_item_count
    one_sd_above = average_items_per_merchant +
      average_items_per_merchant_standard_deviation
    merchant_ids = items_by_merchant_id.map do |merch_id, items|
      merch_id if items.count > one_sd_above
    end.compact
    merchant_ids.map {|id| @parent.merchants.find_by_id(id)}
  end

  def average_item_price_for_merchant(merchant_id)
    items = @parent.items.find_all_by_merchant_id(merchant_id)
    average_item_price = items.inject(0) do |sum, item|
      sum += item.unit_price
    end / items.count
    average_item_price.round(2)
  end

  def average_average_price_per_merchant
    merchant_ids = items_by_merchant_id.keys
    average_average_price = merchant_ids.inject(0) do |sum, id|
      sum += average_item_price_for_merchant(id)
    end / merchant_ids.count
    average_average_price.round(2)
  end

  def item_price_std_dev
    mean = average_average_price_per_merchant
    sum_of_squares = @parent.items.all.inject(0.0) do |sum, item|
      ((item.unit_price - mean)**2) + sum
    end / (@parent.items.all.count - 1)
    Math.sqrt(sum_of_squares).round(2)
  end

  def golden_items
    two_sd_above = average_average_price_per_merchant +
      (item_price_std_dev * 2)
    @parent.items.all.find_all { |item| item.unit_price > two_sd_above }
  end

  def average_invoices_per_merchant
    total_invoices = invoices_per_merchant.inject(0.0) do |sum, invoice_count|
      sum += invoice_count
    end
    (total_invoices / invoices_per_merchant.count).round(2)
  end

  def invoices_per_merchant
    invoices_by_merchant_id.map { |_merchant_id, invoices| invoices.count }
  end

  def invoices_by_merchant_id
    @parent.invoices.all.group_by { |invoice| invoice.merchant_id }
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    sum_of_squares = invoices_per_merchant.inject(0.0) do |sum, invoices|
      ((invoices - mean)**2) + sum
    end / (invoices_per_merchant.count - 1)
    Math.sqrt(sum_of_squares).round(2)
  end

  def top_merchants_by_invoice_count
    two_sd_above = average_invoices_per_merchant +
      (average_invoices_per_merchant_standard_deviation * 2)
    merchant_ids = invoices_by_merchant_id.map do |merch_id, invoices|
      merch_id if invoices.count > two_sd_above
    end.compact
    merchant_ids.map { |id| @parent.merchants.find_by_id(id) }
  end

  def bottom_merchants_by_invoice_count
    two_sd_below = average_invoices_per_merchant -
      (average_invoices_per_merchant_standard_deviation * 2)
    merchant_ids = invoices_by_merchant_id.map do |merch_id, invoices|
      merch_id if invoices.count < two_sd_below
    end.compact
    merchant_ids.map { |id| @parent.merchants.find_by_id(id) }
  end

  def top_days_by_invoice_count
    one_sd_above = invoice_per_day_of_week_std_deviation +
      invoice_mean_for_day_of_week
    invoices_per_day_of_week.map do |day, invoices|
      day if invoices.count > one_sd_above
    end.compact
  end

  def invoice_mean_for_day_of_week
    @parent.invoices.all.count / 7
  end

  def invoice_per_day_of_week_std_deviation
    mean = invoice_mean_for_day_of_week
    sum_of_squares = invoice_counts_per_day_of_week.inject(0.0) do |sum, count|
      ((count - mean)**2) + sum
    end / (invoice_counts_per_day_of_week.count - 1)
    Math.sqrt(sum_of_squares).round(2)
  end

  def invoices_per_day_of_week
    @parent.invoices.all.group_by { |invoice| invoice.created_day_of_week }
  end

  def invoice_counts_per_day_of_week
    invoices_per_day_of_week.map { |_day, invoices| invoices.count }
  end

  def invoice_status(status)
    status = @parent.invoices.find_all_by_status(status)
    ((status.count.to_f / @parent.invoices.all.count) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transactions = @parent.transactions.find_all_by_invoice_id(invoice_id)
    transactions.any? { |transaction| transaction.result == :success }
  end

  def invoice_total(invoice_id)
    return 0 unless invoice_paid_in_full?(invoice_id)
    invoice_items = @parent.invoice_items.find_all_by_invoice_id(invoice_id)
    invoice_items.inject(0.0) do |sum, invoice_item|
      sum + (invoice_item.unit_price * invoice_item.quantity)
    end
  end
end
