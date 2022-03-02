require_relative './sales_engine'
require_relative './transaction'
require_relative './transaction_repo'
require_relative './customer'
require_relative './customer_repo'
require_relative './invoice_item'
require_relative './invoice_item_repo'
require_relative './invoice'
require_relative './invoice_repo'
require_relative './merchant_repo'
require_relative './item_repo'
require_relative './merchant'
require_relative './item'

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def invoice_total(invoice_id)
    all_invoice_items = @sales_engine.invoice_items.find_all_by_invoice_id(invoice_id)

    all_invoice_items.sum do |invoice_item|
      invoice_item.unit_price_to_dollars
    end.round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    all_transactions = @sales_engine.transactions.find_all_by_invoice_id(invoice_id)

    all_transactions.any? do |transaction|
      transaction.result == :success
    end
  end

  def invoice_status(status)
    @sales_engine.find_invoice_status_percentage(status)
  end

  def top_days_by_invoice_count
    @sales_engine.top_day_of_the_week
  end

  def bottom_merchants_by_invoice_count
    @sales_engine.find_bottom_merchants
  end

  def top_merchants_by_invoice_count
    @sales_engine.find_top_merchants
  end

  def average_invoices_per_merchant_standard_deviation
    @sales_engine.find_invoice_standard_deviation
  end

  def average_invoices_per_merchant
    @sales_engine.find_invoice_averages
  end

  def average_items_per_merchant
    @sales_engine.find_average
  end

  def average_items_per_merchant_standard_deviation
    @sales_engine.standard_deviation
  end

  def merchants_with_high_item_count
    @sales_engine.find_merchants_with_most_items
  end

  def convert_to_list(items)
    found = items.each_with_object([]) do |item, array|
      array << item.unit_price.to_f
      array
    end
    found
  end

  def average_item_price_for_merchant(id)
    items = @sales_engine.find_items_by_id(id)
    expected = convert_to_list(items).sum(0.0) / convert_to_list(items).size
    result = BigDecimal(expected, 4)
    result.div(100, 4)
  end

  def average_average_price_per_merchant
    result = @sales_engine.merchants.merchant_list.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    expected = result.sum(0.00) / result.size
    total_averages = BigDecimal(expected, 5).to_s("F")
    total_averages.to_f.floor(2)
  end

  def golden_items
    above_average = (2 * average_average_price_per_merchant) -1
    expected = @sales_engine.items.item_list.find_all do |item|
      (item.unit_price_to_dollars / 1000.0) >= above_average
    end
    expected
  end
end
