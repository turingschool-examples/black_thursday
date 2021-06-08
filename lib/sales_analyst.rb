require 'csv'
require_relative 'sales_engine'

class SalesAnalyst
  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_invoices_per_merchant
    (@se.invoice_repo_total_invoices.to_f / @se.invoice_repo_total_merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    sum = @se.invoice_repo_invoices_per_merchant.sum do |invoice|
      (invoice - average_invoices_per_merchant) ** 2
    end
    std_dev = Math.sqrt(sum / (@se.invoice_repo_total_merchants - 1))
    std_dev.round(2)
  end

  def top_merchants_by_invoice_count
    top_merchants = []
    two_std_dev = average_invoices_per_merchant_standard_deviation * 2
    @se.invoice_repo_group_by_merchant.each do |merchant, invoices|
      if invoices.length - two_std_dev > average_invoices_per_merchant
        top_merchants << @se.merchant_repo_find_by_id(merchant)
      end
    end
    top_merchants
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants = []
    two_std_dev = average_invoices_per_merchant_standard_deviation * 2
    @se.invoice_repo_group_by_merchant.each do |merchant, invoices|
      if invoices.length + two_std_dev < average_invoices_per_merchant
        bottom_merchants << @se.merchant_repo_find_by_id(merchant)
      end
    end
    bottom_merchants
  end

  # def top_days_by_invoice_count
  # end

  def invoice_status(status)
    percentage = (@se.invoice_repo_by_status(status) / @se.invoice_repo_total_invoices.to_f) * 100
    percentage.round(2)
  end

end
