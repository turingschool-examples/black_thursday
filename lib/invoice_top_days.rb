module InvoiceTopDays

  def average_invoices_per_day(engine)
    invoice_repo = @engine.invoices
    invoice_count = invoice_repo.invoices.count
    (invoice_count/7.0).round(2)
  end

  def invoice_creation_days(engine)
    invoice_repo = @engine.invoices
    invoices = invoice_repo.invoices
    invoices.map do |invoice|
      date = invoice.created_at
      date.wday
    end
  end

  def invoices_created_per_day
    days = invoice_creation_days(@engine)
    days_of_week = [0,1,2,3,4,5,6]
    days_of_week.map.with_index do |week_day|
      days.count {|day| day == days_of_week.index(week_day)}
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
    mean = average_invoices_per_day(@engine)
    invoices_per_day = invoices_created_per_day
    sum = sum_of_square_differences_invoices_per_day(invoices_per_day, mean)
    sample_variance = find_sample_variance(invoices, sum)
    standard_deviation(sample_variance)
  end

  def find_top_days_by_invoice_count
    mean = average_invoices_per_day(@engine)
    standard_deviation = invoices_per_day_standard_deviation
    indices = invoices_created_per_day.map.with_index do |invoice_count, index|
      if invoice_count > standard_deviation_above(mean, standard_deviation)
        index
      end
    end
  end

  def top_days_by_invoice_count
    week = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    indices = find_top_days_by_invoice_count
    indices.compact.map do |index|
      week[index]
    end
  end

end
