# frozen_string_literal: true

# Sales Analyst performs various data operations.
class SalesAnalyst
  attr_reader :engine

# include Calculable
  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    @engine.average_items_per_merchant.round(2)
  end

  def average_items_per_merchant_standard_deviation
    @engine.average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    @engine.merchants.merchants_with_high_item_count
  end

  def golden_items
    @engine.items.golden_items
  end

  def average_item_price_for_merchant(id)
    @engine.merchants.average_item_price_for_merchant(id).round(2)
  end

  def average_average_price_per_merchant
    @engine.merchants.average_average_price_per_merchant
  end

  def average_invoices_per_merchant
    @engine.average_invoices_per_merchant.round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    @engine.average_invoices_per_merchant_standard_deviation
  end

  def top_merchants_by_invoice_count
    @engine.merchants.top_merchants_by_invoice_count
  end

  def bottom_merchants_by_invoice_count
    @engine.merchants.bottom_merchants_by_invoice_count
  end

  def invoice_status(type)
    @engine.invoices.invoice_status(type)
  end

  def top_days_by_invoice_count
    @engine.send_down(method: :top_days_by_invoice_count)
  end

  def invoice_paid_in_full?(id)
    @engine.send_down(method: :invoice_paid_in_full?, args: id)
  end

  def invoice_total(invoice_id)
    @engine.invoices.invoice_total(invoice_id)
  end

  def merchants_with_only_one_item
    @engine.merchants.merchants_with_only_one_item
  end

  def merchants_with_only_one_item_registered_in_month(month_name)
    @engine.merchants.merchants_with_only_one_item_registered_in_month(month_name)
  end

  def merchants_with_pending_invoices
    @engine.send_down(method: :merchants_with_pending_invoices)
  end

  def total_revenue_by_date(date)
    @engine.invoices.total_revenue_by_date(date)
  end

  def top_revenue_earners(num = 20)
    @engine.merchants.top_revenue_earners(num)
  end

  def revenue_by_merchant(id)
    @engine.send_down(method: :revenue_by_merchant, args: id)
  end
end
