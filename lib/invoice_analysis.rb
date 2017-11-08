module InvoiceAnalysis
  def days_invoice_created
    se.invoices.all.group_by do |invoice|
      day_of_the_week(invoice.created_at)
    end
  end

  def days_with_number_of_invoices
    days_invoice_created.transform_values do |invoices|
      invoices.count
    end
  end

  def average_invoices_per_day
    average(days_with_number_of_invoices.values)
  end

  def standard_deviation_invoices_per_day
    standard_deviation(days_with_number_of_invoices.values)
  end

  def top_days_by_invoice_count
    top_days = []
    average = average_invoices_per_day
    standard_deviation = standard_deviation_invoices_per_day
    days_with_number_of_invoices.each do |day, invoices|
      if invoices > average + standard_deviation
        top_days << day
      end
    end
    top_days
  end

  def total_number_of_invoices
    se.invoices.all.count
  end

  def number_of_invoices_with_status(status)
    se.invoices.find_all_by_status(status.to_s).count.to_f
  end

  def invoice_status(status)
    total = total_number_of_invoices
    (number_of_invoices_with_status(status) / total * 100).round(2)
  end

  def best_invoice_by_revenue
    se.invoices.all.max_by do |invoice|
      invoice.total
    end
  end

  def best_invoice_by_quantity
    se.invoices.all.max_by do |invoice|
      invoice.total_item_quantities
    end
  end

end
