require_relative 'helper'

module InvoiceAnalyst
 def invoices_per_day
    invoice_repository.invoices_per_day
  end

  def invoices_per_day_values
    invoice_repository.invoices_per_day.values
  end

  def average_invoices_per_merchant
   average(invoices_per_merchant)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoices_per_merchant)
  end

  def top_merchants_by_invoice_count
    two_sd = two_standard_deviations_above_mean(invoices_per_merchant)
    all_merchants.find_all do |merchant|
      merchant.invoices.length > two_sd
    end
  end

  def bottom_merchants_by_invoice_count
    two_sd = two_standard_deviations_below_mean(invoices_per_merchant)
    all_merchants.find_all do |merchant|
      merchant.invoices.length < two_sd
    end
  end

  def average_invoices_per_day
    average(invoices_per_day_values)
  end

  def top_days_by_invoice_count
    one_sd = one_standard_deviation_above_mean(invoices_per_day_values)
    days = []
    invoices_per_day.each do |key, value|
      if value > one_sd
        days << key
      end
    end
   days
  end

  def invoice_statuses
    all_invoices.map do |invoice|
      invoice.status
    end
  end

  def group_statuses
    invoice_statuses.group_by do |status|
      status
    end
  end

  def total_statuses
    all_invoices.count
  end

  def count_statuses
    groups = group_statuses
    groups.each_pair do |status, statuses|
      groups[status] = statuses.length
    end
  end

  def invoice_status(status)
    # returns percentage of total statuses
    percentage(count_statuses[status], total_statuses)
  end

  def total_revenue_by_date(date)
    invoice_repository.get_all_invoice_ids(date)
  end
end