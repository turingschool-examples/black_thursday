# Module for methods concerning invoice analytics
module InvoiceAnalytics
  def invoice_count(merchant_id)
    @invoice_repo.find_all_by_merchant_id(merchant_id).count
  end

  def invoice_count_by_created_date(created_date)
    @invoice_repo.find_all_by_created_date(created_date).count
  end

  def invoices_per_merchant
    @invoice_repo.all.group_by(&:merchant_id)
  end

  def invoices_per_customer
    @invoice_repo.all.group_by(&:customer_id)
  end

  def all_invoice_created_dates
    @invoice_repo.all.map(&:created_at)
  end

  def average_invoices_per_day
    average(@invoice_repo.all.count,
            all_invoice_created_dates.uniq.count).to_f
  end

  def average_invoices_per_day_standard_deviation
    unique_days = @invoice_repo.all.map(&:created_at).uniq
    number_of_invoices_per_day = unique_days.map do |date|
      @invoice_repo.find_all_by_created_date(date).count
    end
    standard_deviation(number_of_invoices_per_day,
                       average_invoices_per_day)
  end

  def number_of_invoices_per_weekday
    number_of_invoices_by_weekday.values
  end

  def average_invoices_per_weekday
    average(number_of_invoices_per_weekday.inject(:+), number_of_invoices_per_weekday.count)
  end

  def average_invoices_per_weekday_standard_deviation
    standard_deviation(number_of_invoices_per_weekday, average_invoices_per_weekday)
  end

  def average_invoices_per_weekday_plus_one_standard_deviation
    average_invoices_per_weekday + average_invoices_per_weekday_standard_deviation
  end

  def number_of_invoices_by_weekday
    weekdays = %w[sunday monday tuesday wednesday thursday friday saturday]
    all_days = @invoice_repo.all.map(&:created_at)
    by_dates = all_days.group_by do |date|
      weekdays[date.wday]
    end
    by_dates.each_key do |id|
      by_dates[id] = by_dates[id].count
    end
  end

  def top_days_by_invoice_count
    threshold = average_invoices_per_weekday_plus_one_standard_deviation
    number_of_invoices_by_weekday.map do |weekday, number|
      weekday.capitalize if number > threshold
    end.compact
  end

  def number_of_invoices_by_status(status_to_find)
    @invoice_repo.all.map(&:status).find_all do |invoice_status|
      invoice_status == status_to_find
    end
  end

  def invoice_total(invoice_id)
    invoice_items = @invoice_item_repo.find_all_by_invoice_id(invoice_id)
    invoice_items.map do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end.reduce(:+)
  end

  def invoices_by_revenue
    successful_transactions = @transaction_repo.find_all_by_result(:success)
    invoices = successful_transactions.map do |transaction|
      @invoice_repo.find_by_id(transaction.invoice_id)
    end.compact
    results = invoices.group_by do |invoice|
      invoice_total(invoice.id)
    end
    results.delete_if do |total, _invoice|
      total.nil?
    end
  end

  def best_invoice_by_revenue
    invoices = invoices_by_revenue
    invoices.values_at(invoices.keys.max).flatten.shift
  end

  def invoices_by_quantity
    successful_transactions = @transaction_repo.find_all_by_result(:success)
    invoices = successful_transactions.map do |transaction|
      @invoice_repo.find_by_id(transaction.invoice_id)
    end.compact
    results = invoices.group_by do |invoice|
      total_invoice_items(invoice.id)
    end
    results.delete_if do |total, _invoice|
      total.nil?
    end
  end

  def best_invoice_by_quantity
    invoices_by_quantity.values_at(invoices_by_quantity.keys.max).flatten.shift
  end
end
