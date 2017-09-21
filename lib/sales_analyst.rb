require_relative './modules/require_helper'

class SalesAnalyst
  include Arithmetic
  include ItemAnalyst
  include InvoiceAnalyst
  include RevenueAnalyst
  include MerchantAnalyst

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    ItemAnalyst.average_items_per_merchant(merchants)
  end

  def average_items_per_merchant_standard_deviation
    ItemAnalyst.average_items_per_merchant_standard_deviation(merchants)
  end

  def merchants_with_high_item_count
    ItemAnalyst.merchants_with_high_item_count(merchants)
  end

  def average_item_price_for_merchant(merchant_id)
    ItemAnalyst.average_item_price_for_merchant(merchant_id, engine)
  end

  def average_average_price_per_merchant
    ItemAnalyst.average_average_price_per_merchant(merchants, engine)
  end

  def golden_items
    ItemAnalyst.golden_items(items)
  end

  def average_invoices_per_merchant
    InvoiceAnalyst.average_invoices_per_merchant(merchants)
  end

  def average_invoices_per_merchant_standard_deviation
    InvoiceAnalyst.average_invoices_per_merchant_standard_deviation(merchants)
  end

  def top_merchants_by_invoice_count
    InvoiceAnalyst.top_merchants_by_invoice_count(merchants)
  end

  def bottom_merchants_by_invoice_count
    InvoiceAnalyst.bottom_merchants_by_invoice_count(merchants)
  end

  def top_days_by_invoice_count
    InvoiceAnalyst.top_days_by_invoice_count(invoices)
  end

  def invoice_status(status)
    InvoiceAnalyst.invoice_status(status, invoices)
  end

  def total_revenue_by_date(date)
    RevenueAnalyst.total_revenue_by_date(date, invoices)
  end

  def top_revenue_earners(x = 20)
    RevenueAnalyst.top_revenue_earners(merchants, engine, x)
  end

  def merchants_ranked_by_revenue
    top_revenue_earners(merchants.length)
  end

  def merchants_with_pending_invoices
    MerchantAnalyst.merchants_with_pending_invoices(merchants)
  end

  def merchants_with_only_one_item
    MerchantAnalyst.merchants_with_only_one_item(merchants)
  end

  def merchants_with_only_one_item_registered_in_month(m, a = MerchantAnalyst)
    a.merchants_with_only_one_item_registered_in_month(m, merchants)
  end

  def revenue_by_merchant(merchant_id, engine)
    RevenueAnalyst.revenue_by_merchant(merchant_id, engine)
  end

  def most_sold_item_for_merchant(merchant_id)
    MerchantAnalyst.most_sold_item_for_merchant(merchant_id, engine, invoices)
  end

  def best_item_for_merchant(merchant_id)
    MerchantAnalyst.best_item_for_merchant(merchant_id, engine)
  end

  private
  def items
    engine.items.all
  end

  def invoices
    engine.invoices.all
  end

  def merchants
    engine.merchants.all
  end

  def customers
    engine.customers.all
  end
end