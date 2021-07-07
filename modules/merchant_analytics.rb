module MerchantAnalytics
  def average_invoices_per_merchant
    @average_invoices_per_merchant ||= average(
      invoices_per_merchant, invoices_per_merchant.length
    ).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    @average_invoices_per_merchant_stdev ||= stdev(
      invoices_per_merchant, average_invoices_per_merchant
    ).round(2)
  end

  def top_merchants_by_invoice_count
    zipped = invoices_per_merchant.zip(merchants)
    average = average_invoices_per_merchant
    stdev = average_invoices_per_merchant_standard_deviation
    found = zipped.find_all { |invoice| invoice[0] > (average + (stdev * 2)) }
    found.map { |invoice| invoice[1] }
  end

  def bottom_merchants_by_invoice_count
    zipped = invoices_per_merchant.zip(merchants)
    average = average_invoices_per_merchant
    stdev = average_invoices_per_merchant_standard_deviation
    found = zipped.find_all { |invoice| invoice[0] < (average - (stdev * 2)) }
    found.map { |invoice| invoice[1] }
  end

  def day_invoice_created
    @day_invoice_created ||= invoices.map do |invoice|
      invoice.created_at.strftime('%A')
    end
  end

  def days_of_week_invoice_count
    days = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
    @days_of_week_invoice_count ||= days.map do |day|
      day_invoice_created.count(day)
    end
  end

  def average_invoices_per_day
    invoice_count = days_of_week_invoice_count
    @avg_invoices_per_day ||= average(
      invoice_count, invoice_count.length
    ).round(2)
  end

  def invoices_per_day_standard_deviation
    @invoices_per_day_stdev ||= stdev(
      days_of_week_invoice_count, average_invoices_per_day
    ).round(2)
  end

  def top_days_by_invoice_count
    days = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
    zipped = days_of_week_invoice_count.zip(days)
    average = average_invoices_per_day
    stdev = invoices_per_day_standard_deviation
    found = zipped.find_all { |invoice| invoice[0] > (average + (stdev * 1)) }
    found.map { |day| day[1] }
  end

  def invoice_status(status)
    numerator = invoice_repo.find_all_by_status(status).count.to_f
    denominator = invoices.count
    ((numerator / denominator) * 100).round 2
  end

  def total_revenue_by_date(date)
    invoices = invoice_repo.find_all_by_date(date)
    invoice_ids = invoices.find_all(&:is_paid_in_full?).map(&:id)
    invoice_items = invoice_ids.map do |invoice_id|
      invoice_item_repo.find_all_by_invoice_id(invoice_id)
    end.flatten
    invoice_items.map { |ii| ii.unit_price * ii.quantity }.reduce :+
  end

  def top_revenue_earners(num_merchants = 20)
    merchant_revenues = merchants.map do |merchant|
      revenue_by_merchant(merchant.id).to_f
    end
    zipped = merchants.zip(merchant_revenues).to_h
    sorted = zipped.max_by(num_merchants) { |_k, v| v }
    sorted.map { |subarray| subarray[0] }
  end

  def find_total_item_prices(invoice_item_array)
    invoice_item_array.map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end
  end

  def revenue_by_merchant(merchant_id)
    invoices = invoice_repo.find_all_by_merchant_id(merchant_id)
    invoice_ids = invoices.find_all(&:is_paid_in_full?).map(&:id)
    invoice_items = invoice_item_repo.find_all_by_mult_invoice_ids(invoice_ids)
    invoice_items.flatten!
    find_total_item_prices(invoice_items).reduce :+
  end

  def merchants_total_revenue
    total_revenue = merchants.map do |merchant|
      revenue_by_merchant(merchant.id)
    end
    total_revenue.map { |num| num || 0 }
  end

  def merchants_ranked_by_revenue
    zipped = merchants.zip(merchants_total_revenue).to_h
    sorted = zipped.sort_by { |_k, v| v }
    sorted.map { |merchant| merchant[0] }.reverse
  end

  def merchants_with_pending_invoices
    pending_invoices = invoices.reject(&:is_paid_in_full?)
    merchant_ids = pending_invoices.map(&:merchant_id).uniq
    merchant_ids.map do |merchant_id|
      merchants.find_all { |merchant| merchant.id == merchant_id }
    end.flatten
  end

  def merchants_with_only_one_item
    merchant_items = merchants.map { |merchant| merchant.items.length }
    zipped = merchants.zip(merchant_items)
    only_one = zipped.find_all { |subarray| subarray[1] == 1 }
    only_one.map { |subarray| subarray[0] }
  end

  def merchants_with_only_one_item_registered_in_month(month)
    all_merchants = merchants.find_all do |merchant|
      merchant.created_at.month == Date::MONTHNAMES.index(month)
    end
    item_count = all_merchants.map { |merchant| merchant.items.length }
    one = all_merchants.zip(item_count).find_all { |subarray| subarray[1] == 1 }
    one.map { |subarray| subarray[0] }
  end

  def most_sold_item_for_merchant(merchant_id)
    merchants_invoices = invoice_repo.find_all_by_merchant_id(merchant_id)
    invoice_ids = merchants_invoices.find_all(&:is_paid_in_full?).map(&:id)
    i_items = invoice_item_repo.find_all_by_mult_invoice_ids(invoice_ids)
    sorted = i_items.flatten.max_by(&:quantity).quantity
    highest_quantity = search_invoice_items_by_quantity(i_items.flatten, sorted)
    @item_repo.find_all_by_invoice_items(highest_quantity)
  end

  def search_invoice_items_by_quantity(invoice_item_array, quantity)
    invoice_item_array.find_all do |invoice_item|
      invoice_item.quantity == quantity
    end
  end

  def best_item_for_merchant(merchant_id)
    merchants_invoices = invoice_repo.find_all_by_merchant_id(merchant_id)
    invoice_ids = merchants_invoices.find_all(&:is_paid_in_full?).map(&:id)
    invoice_items = invoice_item_repo.find_all_by_mult_invoice_ids(invoice_ids)
    highest_revenue = sort_invoice_items_by_total_revenue(invoice_items)
    item_repo.find_by_id(highest_revenue.item_id)
  end

  def sort_invoice_items_by_total_revenue(invoice_items)
    invoice_items.flatten.max_by do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end
  end
end
