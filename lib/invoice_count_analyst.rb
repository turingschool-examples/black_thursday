require_relative 'statistics'
require_relative 'sales_engine'
require_relative 'date_accessor'

class InvoiceCountAnalyst
  include Statistics

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def all_merchants
    engine.merchants.all
  end

  def merchant_invoice_count
    engine.merchants.all.map { |m| m.invoices.count }
  end

  def average_invoices_per_merchant
    find_average(merchant_invoice_count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    stdev(merchant_invoice_count).round(2)
  end

  def top_merchants_by_invoice_count
    threshold = (stdev(merchant_invoice_count) * 2)
    threshold += find_average(merchant_invoice_count)
    all_merchants.find_all { |m| m.invoices.count > threshold }
  end

  def bottom_merchants_by_invoice_count
    threshold = find_average(merchant_invoice_count)
    threshold -= (stdev(merchant_invoice_count) * 2)
    all_merchants.find_all { |m| m.invoices.count < threshold }
  end

  def top_days_by_invoice_count
    day_hash = engine.invoices.all.group_by {|i| i.created_at.wday}
    day_data = day_hash.values.map { |day| day.count}
    threshold = (stdev(day_data) + find_average(day_data)).round
    top_days = day_hash.keys.find_all { |day| day_hash[day].count > threshold }
    top_days.map { |day| DateAccessor.weekdays[day] }
  end

  def invoice_status(status_symbol)
    numerator = engine.invoices.find_all_by_status(status_symbol).count
    denominator = engine.invoices.all.count
    ((numerator.to_f / denominator) * 100).round(2)
  end

  def merchants_with_pending_invoices
    pending = engine.invoices.all.find_all {|i| i.is_paid_in_full? == false }
    pending.map {|i| i.merchant }.uniq
  end

end