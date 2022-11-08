# frozen_string_literal: true

# Sales Analyst performs various data operations.
class SalesAnalyst
  attr_reader :engine

# include Calculable
  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    @engine.send_to_repo(method: :average_items_per_merchant).round(2)
  end

  def average_items_per_merchant_standard_deviation
    @engine.send_to_repo(method: :average_items_per_merchant_standard_deviation)
  end

  def merchants_with_high_item_count
    @engine.send_to_repo(method: :merchants_with_high_item_count)
  end

  def golden_items
    @engine.send_to_repo(method: :golden_items)
  end

  def average_item_price_for_merchant(id)
    @engine.send_to_repo(method: :average_item_price_for_merchant, args: id).round(2)
  end

  def average_average_price_per_merchant
    @engine.send_to_repo(method: :average_average_price_per_merchant)
  end

  def average_invoices_per_merchant
    @engine.send_to_repo(method: :average_invoices_per_merchant).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    @engine.send_to_repo(method: :average_invoices_per_merchant_standard_deviation)
  end

  def top_merchants_by_invoice_count
    @engine.send_to_repo(method: :top_merchants_by_invoice_count)
  end

  def bottom_merchants_by_invoice_count
    @engine.send_to_repo(method: :bottom_merchants_by_invoice_count)
  end

  def invoice_status(type)
    @engine.send_to_repo(method: :invoice_status, args: type)
  end

  def top_days_by_invoice_count
    @engine.send_to_repo(method: :top_days_by_invoice_count)
  end

  def invoice_paid_in_full?(id)
    @engine.send_to_repo(method: :invoice_paid_in_full?, args: id)
  end

  def invoice_total(invoice_id)
    @engine.send_to_repo(method: :invoice_total, args: invoice_id)
  end

  def merchants_with_only_one_item
    @engine.send_to_repo(method: :merchants_with_only_one_item)
  end

  def merchants_with_only_one_item_registered_in_month(month_name)
    @engine.send_to_repo(method: :merchants_with_only_one_item_registered_in_month, args: month_name)
  end

  def merchants_with_pending_invoices
    @engine.send_to_repo(method: :merchants_with_pending_invoices)
  end

  def total_revenue_by_date(date)
    @engine.send_to_repo(method: :total_revenue_by_date, args: date.to_s)
  end

  def top_revenue_earners(num = 20)
    @engine.send_to_repo(method: :top_revenue_earners, args: num)
  end

  def revenue_by_merchant(id)
    @engine.send_to_repo(method: :revenue_by_merchant, args: id)
  end
end
