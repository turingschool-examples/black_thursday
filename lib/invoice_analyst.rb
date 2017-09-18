module InvoiceAnalyst

  def average_invoices_per_merchant
    invoice_count = @engine.invoice_list.count
    merchant_count = @engine.merchant_list.count
    ((invoice_count.to_f / merchant_count.to_f)).round(2)
  end

  def sum_of_square_differences_invoice_count(engine, mean)
    merchants = @engine.merchant_list
    merchants.reduce(0) do |result, merchant|
      difference_squared = (mean - merchant.invoices.count) ** 2
      result + difference_squared
    end
  end

  def average_invoices_per_merchant_standard_deviation
    merchants = @engine.merchant_list
    mean = average_invoices_per_merchant
    sum = sum_of_square_differences_invoice_count(@engine, mean)
    sample_variance = find_sample_variance(merchants, sum)
    standard_deviation(sample_variance)
  end

  def top_merchants_by_invoice_count
    merchants = @engine.merchant_list
    mean = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    merchants.find_all do |merchant|
      merchant.invoices.count > standard_deviation_above(mean, standard_deviation, 2)
    end
  end

  def bottom_merchants_by_invoice_count
    merchants = @engine.merchant_list
    mean = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    merchants.find_all do |merchant|
      merchant.invoices.count < mean - (standard_deviation * 2)
    end
  end

  def invoice_status_count
    statuses = {:returned => 0, :pending => 0, :shipped => 0}
    invoices = @engine.invoice_list
    invoices.each do |invoice|
      if invoice.status == "returned"
        statuses[:returned] += 1
      elsif invoice.status == "pending"
        statuses[:pending] += 1
      else
        statuses[:shipped] += 1
      end
    end
    statuses
  end

  def format_status_percentage(value, status_total)
    decimal = value.to_f / status_total
    percent = decimal * 100
    rounded_percent = percent.round(2)
  end

  def invoice_status_percentages
    status_counts = invoice_status_count
    status_total = status_counts.values.sum
    status_counts.each do |key, value|
      status_counts[key] = format_status_percentage(value, status_total)
    end
    status_counts
  end

  def invoice_status(search_status)
    status_percentages = invoice_status_percentages
    status_percentages[search_status]
  end




end
