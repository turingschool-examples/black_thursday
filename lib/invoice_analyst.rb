require_relative './statistics'

module InvoiceAnalyst
  include Statistics

  def average_invoices_per_merchant
    averager(invoice_count, merchant_count)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(
      count_all_invoices_for_each_merchant,
      invoice_count,
      merchant_count)
  end

  def top_merchants_by_invoice_count
    minimum = top_merchants_by_invoice_threshold
    find_merchants(minimum, 'min')
  end

  def bottom_merchants_by_invoice_count
    maximum = bottom_merchants_by_invoice_threshold
    find_merchants(maximum, 'max')
  end

  def top_days_by_invoice_count
    threshold = threshold_for_top_invoice_days
    accumulate_invoice_by_day.reduce([]) do |result, (day, count)|
      result << day if count >= threshold
      result
    end
  end

  def invoice_status(status)
    separated = invoice_status_accumulator
    BigDecimal((10000 * separated[status].to_f / invoice_count).round)/100
  end

  private
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

  def find_merchants(threshold, mode)
    accumulate_merchant_invoices.reduce([]) do |result, (merchant, invoices)|
      add_merchant(merchant, result) if invoices >= threshold && mode == 'min'
      add_merchant(merchant, result) if invoices <= threshold && mode == 'max'
      result
    end
  end

  def add_merchant(merchant_id, result)
    result << se.merchants.find_by_id(merchant_id)
  end

  def top_merchants_by_invoice_threshold
    twice_stdev = (2 * average_invoices_per_merchant_standard_deviation)
    average_invoices_per_merchant + twice_stdev
  end

  def bottom_merchants_by_invoice_threshold
    twice_stdev = (2 * average_invoices_per_merchant_standard_deviation)
    average_invoices_per_merchant - twice_stdev
  end

  def threshold_for_top_invoice_days
    average_invoices_per_day + standard_deviation_of_invoices_per_day
  end

  def standard_deviation_of_invoices_per_day
    standard_deviation(
      invoice_count_by_day,
      invoice_count,
      7
    )
  end

  def invoice_count_by_day
    accumulate_invoice_by_day.map do |pair|
      pair[1]
    end
  end

  def accumulate_invoice_by_day
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

  def invoice_status_accumulator
    se.invoices.invoices.reduce({}) do |result, invoice|
      result[invoice.status] = 0 if result[invoice.status].nil?
      result[invoice.status] += 1
      result
    end
  end
end
