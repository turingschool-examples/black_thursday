module InvoiceAnalyst
  def invoice_std_deviation(invoices_per_day)
    Math.sqrt(invoices_per_day.map do |total|
      (total - avg_inv_per_day)**2
    end.sum / 7).round
  end

  def invoices_per_day
    grouped_invoices.values.map(&:length)
  end

  def day_array
    grouped_invoices.keys.zip(invoices_per_day)
  end

  def days_with_high_invoices(day_array, avg_inv_per_day, deviation)
    day_array.select do |invoice|
      invoice[1] > avg_inv_per_day + deviation
    end.map(&:first)
  end

  def grouped_invoices
    invoices.group_by {|invoice|invoice.created_at.strftime("%A")}
  end

  def avg_inv_per_day
    invoices.length / 7
  end
end
