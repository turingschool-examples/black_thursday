require_relative 'arithmetic'

module InvoiceAnalyst
  extend Arithmetic

  def self.average_invoices_per_merchant(merchants)
    average(merchants.map {|merchant| merchant.invoices.length})
  end

  def self.average_invoices_per_merchant_standard_deviation(merchants)
    standard_deviation(merchants.map {|merchant| merchant.invoices.length})
  end

  def self.top_merchants_by_invoice_count(merchants)
    mean      = average_invoices_per_merchant(merchants)
    deviation = average_invoices_per_merchant_standard_deviation(merchants)
    count     = mean + (deviation * 2)
    merchants.select {|merchant| merchant.invoices.length > count}
  end

  def self.bottom_merchants_by_invoice_count(merchants)
    mean      = average_invoices_per_merchant(merchants)
    deviation = average_invoices_per_merchant_standard_deviation(merchants)
    count     = mean - (deviation * 2)
    merchants.select {|merchant| merchant.invoices.length < count}
  end

  def self.top_days_by_invoice_count(invoices)
    arg_1 = day_array(invoices)
    arg_2 = avg_inv_per_day(invoices)
    arg_3 = invoice_std_deviation(invoices_per_day(invoices), invoices)
    days_with_high_invoices(arg_1, arg_2, arg_3)
  end

  def self.invoice_std_deviation(invoices_per_day, invoices)
    Math.sqrt(invoices_per_day(invoices).map do |total|
      (total - avg_inv_per_day(invoices))**2
    end.sum / 7).round
  end

  def self.invoices_per_day(invoices)
    grouped_invoices(invoices).values.map(&:length)
  end

  def self.day_array(invoices)
    grouped_invoices(invoices).keys.zip(invoices_per_day(invoices))
  end

  def self.days_with_high_invoices(day_array, avg_inv_per_day, deviation)
    day_array.select do |invoice|
      invoice[1] > avg_inv_per_day + deviation
    end.map(&:first)
  end

  def self.grouped_invoices(invoices)
    invoices.group_by {|invoice|invoice.created_at.strftime("%A")}
  end

  def self.avg_inv_per_day(invoices)
    invoices.length / 7
  end

  def self.invoice_status(status, invoices)
    total     = invoices.length
    selected  = invoices.select {|invoice| invoice.status == status}
    ((selected.length.to_f / total.to_f) * 100.0).round(2)
  end
end