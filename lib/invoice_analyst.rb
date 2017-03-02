module InvoiceAnalyst

  def invoice_days
    invoices.map { |invoice| invoice.created_at.strftime('%A')}
  end

  def invoices_by_day
    invoice_days.reduce(Hash.new(0)) do |total, day|
      total[day] = 0 if total[day].nil?
      total[day] += 1
      total
    end
  end

  def top_days_by_invoice_count
    invoices_by_day.keys.select do |day|
      invoices_by_day[day] > top_threshold(invoices_by_day.values, 1)
    end
  end

  def invoice_status(status)
    find_all_by_status = engine.invoices.find_all_by_status(status)
    ((find_all_by_status.count / invoices.count.to_f) * 100).round(2)
  end

  def total_revenue_by_date(date)
    invoices_by_date ||= invoices.select do |invoice|
      invoice.created_at == date
    end
    invoices_by_date.map do |invoice|
      invoice.total
    end.reduce(:+)
  end

  private

  def invoices
    engine.invoices.all
  end

  def invoices_by_day_average
    average(invoices_by_day.values)
  end

  def invoices_by_day_standard_deviation
    standard_deviation(invoices_by_day.values)
  end

end