# Module for methods concerning invoice analytics
module InvoiceAnalytics
  def average_invoices_per_merchant
    average(number_of(:invoices), number_of(:merchants)).to_f
  end

  def average_invoices_per_merchant_standard_deviation
    unique_merchants = @invoice_repo.all.map(&:merchant_id).uniq
    number_of_invoices_for_each_merchant = unique_merchants.map do |merchant_id|
      invoice_count(merchant_id)
    end
    standard_deviation(number_of_invoices_for_each_merchant,
                       average_invoices_per_merchant)
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

  def top_days_by_invoice_count
    threshold = average_invoices_per_weekday_plus_one_standard_deviation
    number_of_invoices_by_weekday.map do |weekday, number|
      weekday.capitalize if number > threshold
    end.compact
  end

  def best_invoice_by_revenue
    invoices = invoices_by_revenue
    invoices.values_at(invoices.keys.max).flatten.shift
  end

  def best_invoice_by_quantity
    invoices_by_quantity.values_at(invoices_by_quantity.keys.max).flatten.shift
  end
end
