require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_average_price_per_merchant
    @sales_engine.average_average_price_per_merchant
  end

  def average_items_per_merchant
    @sales_engine.average_items_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    @sales_engine.average_items_per_merchant_standard_deviation
  end

  def average_item_price_for_merchant(merchant_id)
    @sales_engine.average_item_price_for_merchant(merchant_id)
  end

  def average_invoices_per_merchant
    @sales_engine.average_invoices_per_merchant
  end

  def average_invoices_per_merchant_standard_deviation
    @sales_engine.stdev_invoices_per_merchant
  end

  def best_item_for_merchant(merchant_id)
    @engine.best_item_for_merchant(merchant_id)
  end

  def bottom_merchants_by_invoice_count
    @sales_engine.bottom_merchants_by_invoice_count
  end

  def golden_items
    @sales_engine.golden_items
  end

  def invoice_paid_in_full?(invoice_id)
    @sales_engine.invoice_paid_in_full?(invoice_id)
  end

  def invoice_status(status)
    @sales_engine.invoice_status(status)
  end

  def invoice_total(invoice_id)
    @sales_engine.invoice_total(invoice_id)
  end

  def merchants_with_high_item_count
    @sales_engine.merchants_with_high_item_count
  end

  def merchants_with_only_one_item
    @sales_engine.merchants_with_only_one_item
  end

  def merchants_with_only_one_item_registered_in_month(month)
    @sales_engine.merchants_with_only_one_item_registered_in_month(month)
  end

  def merchants_with_pending_invoices
    @sales_engine.merchants_with_pending_invoices
  end

  def most_sold_item
    @sales_engine.most_sold_item(merchant_id)
  end

  def revenue_by_merchant(merchant_id)
    @sales_engine.revenue_by_merchant(merchant_id)
  end

  def top_buyers(x = 20)
    @sales_engine.top_buyers(x)
  end

  def top_days_by_invoice_count
    @sales_engine.top_days_by_invoice_count
  end

  def top_merchants_by_invoice_count
    @sales_engine.top_merchants_by_invoice_count
  end

  def top_revenue_earners(x = 20)
    @sales_engine.top_revenue_earners(x)
  end

  def total_revenue_by_date(date)
    @sales_engine.total_revenue_by_date(date)
  end
end
