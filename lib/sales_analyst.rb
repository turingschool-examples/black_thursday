require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    @sales_engine.average_items_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    @sales_engine.average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    @sales_engine.merchants_with_high_item_count
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

  def top_merchants_by_invoice_count
    @sales_engine.top_merchants_by_invoice_count
  end

  def bottom_merchants_by_invoice_count
    @sales_engine.bottom_merchants_by_invoice_count
  end

  def invoice_status(status)
    @sales_engine.invoice_percentage_by_status(status)
  end

  def top_days_by_invoice_count
    @sales_engine.top_days_by_invoice_count
    @sales_engine.merchants.merchants_with_high_item_count
  end
end
