module InvoiceTopDays

  def average_invoices_per_day
    invoice_count = @engine.invoice_list.count
    (invoice_count/7.0).round(2)
  end

  def invoice_creation_days
    invoices = @engine.invoice_list
    invoices.map do |invoice|
      date = invoice.created_at
      date.strftime("%A")
    end
  end

  def invoices_created_per_day
    days = invoice_creation_days
    days_of_week = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
    invoice_count_per_day = Hash[days_of_week.map {|day| [day, 0]}]
    invoice_count_per_day.each do |day, invoice_count|
      invoice_count_per_day[day] = days.count(day)
    end
  end

  def sum_of_square_differences_invoices_per_day(invoices_per_day, mean)
    invoices_per_day.reduce(0) do |result, day_count|
      difference_squared = (mean - day_count) ** 2
      result + difference_squared
    end
  end

  def invoices_per_day_standard_deviation
    invoices = @engine.invoice_list
    mean = average_invoices_per_day
    invoices_per_day = invoices_created_per_day.values
    sum = sum_of_square_differences_invoices_per_day(invoices_per_day, mean)
    sample_variance = find_sample_variance(invoices_per_day, sum)
    standard_deviation(sample_variance)
  end

  def top_days_by_invoice_count
    mean = average_invoices_per_day
    standard_deviation = invoices_per_day_standard_deviation
    invoices_per_day = invoices_created_per_day
    top_days = []
    invoices_per_day.each do |day, invoice_count|
      if invoice_count > standard_deviation_above(mean, standard_deviation)
        top_days << day
      end
    end
    top_days
  end

end
