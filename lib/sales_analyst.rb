require 'csv'
require_relative 'sales_engine'

class SalesAnalyst
  def initialize(sales_engine)
    @se = sales_engine
  end

  def total_revenue_by_date(date)
    @se.revenue_by_date(date)[date]
  end

  def top_revenue_earners(number = 20)
    top_earners = @se.merchant_total_revenue_to_instance.max_by(number) do |merchant, revenue|
      revenue
    end
    top_earners.flat_map do |earner_pair|
      earner_pair.first
    end
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

  def average_invoice_per_day
    (@se.invoice_repo_total_invoices.to_f / 7).round(2)
  end

  def average_invoice_per_day_standard_deviation
    sum = @se.invoice_repo_invoices_per_day.sum do |invoice|
      (invoice - average_invoice_per_day) ** 2
    end
    std_dev = Math.sqrt(sum / (7 - 1))
    std_dev.round(2)
  end

  def top_days_by_invoice_count
    top_days = []
    @se.invoice_repo_invoices_day_created_date.each do |day, invoices|
      if (invoices.length - average_invoice_per_day_standard_deviation) > average_invoice_per_day
        top_days << day
      end
    end
    top_days
  end

  def invoice_status(status)
    percentage = (@se.invoice_repo_by_status(status) / @se.invoice_repo_total_invoices.to_f) * 100
    percentage.round(2)
  end


  def average_items_per_merchant
    (@se.item_repo_total_items.to_f / @se.item_repo_total_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    sum = @se.item_repo_items_per_merchant.sum do |items|
      (items - average_items_per_merchant) ** 2
    end
    std_dev = sum / (@se.item_repo_total_merchants - 1)
    Math.sqrt(std_dev).round(2)
  end

  def merchants_with_high_item_count
    high_merchants = []
    @se.item_repo_group_items_by_merchant.each do |merchant, items|
      if items.length - average_items_per_merchant_standard_deviation > average_items_per_merchant
        high_merchants << @se.merchant_repo_find_by_id(merchant)
      end
    end
    high_merchants
  end

  def average_item_price_for_merchant(merchant_id)
    (@se.item_repo_merchant_price_sum(merchant_id) / @se.item_repo_total_items_by_merchant(merchant_id)).round(2)
  end

  def average_average_price_per_merchant
    average_total = 0
    @se.item_repo_group_items_by_merchant.each do |merchant, items|
      average_total += average_item_price_for_merchant(merchant)
    end
    (average_total / @se.item_repo_group_items_by_merchant.keys.length).round(2)
  end

  def average_item_price
    @se.item_repo_total_item_price / @se.item_repo_total_items
  end

  def item_price_standard_deviation
    sum = @se.item_repo_all_items_by_price.sum do |item|
      (item - average_item_price) ** 2
    end
    std_dev = sum / (@se.item_repo_total_items - 1)
    Math.sqrt(std_dev).round(2)
  end

  def golden_items
    @se.item_repo_all_items.find_all do |item|
      (item.unit_price - item_price_standard_deviation * 2) > average_item_price
    end
  end

  def invoice_paid_in_full?(invoice_id)
    @se.transaction_repo_invoice_paid_in_full(invoice_id)
  end

  def invoice_total(invoice_id)
    @se.invoice_items_repo_invoice_total_by_id(invoice_id)
  end

  def merchants_with_pending_invoices
    @se.pending_inovices.map do |invoice|
      @se.merchant_repo_find_by_id(invoice.merchant_id)
    end.uniq
  end

  def merchants_with_only_one_item
    single_item_merchants = []
    @se.group_items_by_merchant_instance.each do |key, value|
      if value.length == 1
        single_item_merchants << key
      end
    end
    single_item_merchants
  end

  def merchants_with_only_one_item_registered_in_month(month)
    single_item_merchants = []
    @se.group_items_by_merchant_instance.each do |merchant, items|
      if (items.length == 1) && (merchant.created_at.strftime('%B') == month)
        single_item_merchants << merchant
      end
    end
    single_item_merchants
  end

  def revenue_by_merchant(id)
    @se.merchant_revenue(id)
  end
end
