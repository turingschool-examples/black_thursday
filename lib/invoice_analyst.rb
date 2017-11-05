module InvoiceAnalyst
  def averager(object_count, by_object_count)
    (object_count.to_f / by_object_count).round(2)
  end

  def standard_deviation(population, object_count, by_object_count)
    average = averager(object_count, by_object_count)
    Math.sqrt(population.map do |sub_count|
      (average - sub_count) ** 2
    end.sum / (by_object_count - 1 )).round(2)
  end

  def average_invoices_per_merchant
    averager(invoice_count, merchant_count)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(
      count_all_invoices_for_each_merchant,
      invoice_count,
      merchant_count)
  end

  def count_all_invoices_for_each_merchant
    se.merchants.merchants.map do |merchant|
      merchant.invoices.count
    end
  end

  def accumulate_merchant_invoices
    se.invoices.invoices.reduce({}) do |result, invoice|
      result[invoice.merchant_id] = 0 if result[invoice.merchant_id].nil?
      result[invoice.merchant_id] += 1
      result
    end
  end

  def top_merchants_by_invoice_count
    minimum = top_merchants_by_invoice_threshold
    accumulate_merchant_invoices.reduce([]) do |result, (merchant, invoices)|
      result << se.merchants.find_by_id(merchant) if invoices >= minimum
      result
    end
  end

  def top_merchants_by_invoice_threshold
    twice_stdev = (2 * average_invoices_per_merchant_standard_deviation)
    average_invoices_per_merchant + twice_stdev
  end

  def bottom_merchants_by_invoice_count
    minimum = bottom_merchants_by_invoice_threshold
    accumulate_merchant_invoices.reduce([]) do |result, (merchant, invoices)|
      result << se.merchants.find_by_id(merchant) if invoices <= minimum
      result
    end
  end

  def bottom_merchants_by_invoice_threshold
    twice_stdev = (2 * average_invoices_per_merchant_standard_deviation)
    average_invoices_per_merchant - twice_stdev
  end

  def top_days_by_invoice_count
    invoice_count_by_day.reduce([]) do |result, (day, count)|
      if count >= threshold_for_top_invoice_days
        result << day
      end
      result
    end
  end

  def threshold_for_top_invoice_days
    average_invoices_per_day + standard_deviation_of_invoices_per_day
  end

  def standard_deviation_of_invoices_per_day
    Math.sqrt(invoice_count_by_day.values.map do |value|
      (average_invoices_per_day - value) ** 2
    end.sum / (7 - 1 )).round(2)
  end

  def invoice_count_by_day
    se.invoices.invoices.reduce({}) do |result, invoice|
      day = invoice.created_at.strftime('%A')
      result[day] = 0 if result[day].nil?
      result[day] += 1
      result
    end
  end

  def average_invoices_per_day
    (invoice_count) / 7
  end

  def invoice_status(status)
    separated = invoice_status_accumulator
    BigDecimal((10000 * separated[status].to_f / invoice_count).round)/100
  end

  def invoice_status_accumulator
    se.invoices.invoices.reduce({}) do |result, invoice|
      result[invoice.status] = 0 if result[invoice.status].nil?
      result[invoice.status] += 1
      result
    end
  end
end
