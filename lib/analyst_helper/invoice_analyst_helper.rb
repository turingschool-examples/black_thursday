module InvoiceAnalyst
  def number_of_invoices_per_day
    @all_invoices_per_day.values.map(&:count)
  end

  def number_of_invoices_per_merchant
    @all_invoices_per_merchant.values.map(&:count)
  end

  def average_invoices_per_merchant
    invoice_count = @all_invoices_per_merchant.values.map(&:count)
    find_mean(invoice_count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(number_of_invoices_per_merchant).round(2)
  end

  def top_days_by_invoice_count
    std_dev = standard_deviation(number_of_invoices_per_day)
    mean = find_mean(number_of_invoices_per_day)
    high_traffic_days = []
    @all_invoices_per_day.each_pair do |day, invoices|
      if std_dev_above_mean(invoices.count, mean, std_dev) >= 1
        high_traffic_days << day
      end
    end
    high_traffic_days
  end

  def percent_of_total_invoices_per_status
    all_invoices = @all_invoices_per_day.values.flatten
    total = all_invoices.count
    grouped_by_status = all_invoices.group_by(&:status)
    grouped_by_status.each do |status,invoices|
      percent = (invoices.count / total.to_f) * 100
      grouped_by_status[status] = percent.round(2)
    end
    grouped_by_status
  end

  def invoice_status(status)
    percent_of_total_invoices_per_status[status]
  end
end
