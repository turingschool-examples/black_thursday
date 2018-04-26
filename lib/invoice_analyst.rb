# frozen_string_literal: true

module InvoiceAnalyst
  def invoices_per_merchant
    invoices = merchants.all.map do |merchant|
      merchant.invoices.length
    end
  end

  def average_invoices_per_merchant
    invoices = invoices_per_merchant
    average(invoices).round(2).to_f
  end

  def average_invoices_per_merchant_standard_deviation
    invoices = invoices_per_merchant
    average = average_invoices_per_merchant
    standard_deviation(invoices, average)
  end

  def top_merchants_by_invoice_count
    invoices = invoices_per_merchant
    average = average_invoices_per_merchant
    std = standard_deviation(invoices, average)
    merchants.all.find_all do |merchant|
      by_deviation(merchant.invoices.length, average, std, 2)
    end
  end

  def bottom_merchants_by_invoice_count
    invoices = invoices_per_merchant
    average = average_invoices_per_merchant
    std = standard_deviation(invoices, average)
    merchants.all.find_all do |merchant|
      by_deviation(merchant.invoices.length, average, std, -2)
    end
  end

  def top_days_by_invoice_count
    days = invoices.all.map { |invoice| invoice.created_at.wday }
    group = days.group_by { |day| day }
    group.each { |key, value| group[key] = value.length }
    average = average(group.values)
    std = standard_deviation(group.values, average)
    day_and_invoice_num = group.select { |_, value| (value > (average + std)) }
    day_and_invoice_num.keys.map { |day| Date::DAYNAMES[day] }
  end

  def invoice_status(status)
    invoice_status = invoices.all.map(&:status)
    group = invoice_status.group_by { |status| status }
    group.each { |key, value| group[key] = value.length }
    a = BigDecimal(group[status])
    b = BigDecimal(invoices.all.length)
    invoice_status_percentage = a / b * 100
    invoice_status_percentage.to_f.round(2)
  end
end
