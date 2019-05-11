require 'date'
require_relative 'analytics/customer_analytics'
require_relative 'analytics/invoice_analytics'
require_relative 'analytics/item_analytics'
require_relative 'analytics/merchant_analytics'

# Sales Analyst class for analyzing data
class SalesAnalyst
  include MerchantAnalytics
  include ItemAnalytics
  include InvoiceAnalytics
  include CustomerAnalytics

  attr_reader :engine
  def initialize(sales_engine)
    @engine = sales_engine
    @merchant_repo = @engine.merchants
    @item_repo = @engine.items
    @invoice_repo = @engine.invoices
    @customer_repo = @engine.customers
    @transaction_repo = @engine.transactions
    @invoice_item_repo = @engine.invoice_items
  end

  def average(sum, total_elements)
    (BigDecimal(sum) / BigDecimal(total_elements)).round(2)
  end

  def standard_deviation(set, mean)
    mean_difference_squared = set.inject(0) do |sum, number_in_set|
      sum + ((number_in_set - mean)**2)
    end
    Math.sqrt(mean_difference_squared / (set.count - 1)).round(2)
  end

  def number_of(collection)
    repos = {
      merchants: @merchant_repo,
      items: @item_repo,
      invoices: @invoice_repo
    }
    repos[collection].all.count
  end

  def items_per_merchant
    @item_repo.all.group_by(&:merchant_id)
  end

  def number_of_items_per_merchant
    number_of_items_per_merchant = items_per_merchant
    number_of_items_per_merchant.each do |id, items|
      number_of_items_per_merchant[id] = items.length
    end
    number_of_items_per_merchant
  end

  def number_of_invoices_per_merchant
    number_of_invoices_per_merchant = invoices_per_merchant
    number_of_invoices_per_merchant.each do |id, invoices|
      number_of_invoices_per_merchant[id] = invoices.length
    end
    number_of_invoices_per_merchant
  end

  def merchants_per_count
    merchants_per_count = {}
    number_of_invoices_per_merchant.each do |id, count|
      if merchants_per_count[count]
        merchants_per_count[count] << id
      else
        merchants_per_count[count] = [] << id
      end
    end
    merchants_per_count
  end

  def average_invoices_per_merchant
    average(number_of(:invoices), number_of(:merchants)).to_f
  end

  def average_invoices_per_merchant_standard_deviation
    unique_merchants = @invoice_repo.all.map(&:merchant_id).uniq
    number_of_invoices_for_each_merchant = unique_merchants.map do |merchant_id|
      invoice_count(merchant_id)
    end
    standard_deviation(number_of_invoices_for_each_merchant,
                       average_invoices_per_merchant)
  end

  def sum_of_item_price_for_merchant(merchant_id)
    items_per_merchant[merchant_id].inject(0) do |sum, item|
      sum + item.unit_price
    end
  end

  def average_items_per_merchant_plus_one_standard_deviation
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def average_invoices_per_merchant_plus_two_standard_deviations
    (average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2)).round(2)
  end

  def average_invoices_per_merchant_minus_two_standard_deviations
    (average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transactions = @transaction_repo.find_all_by_invoice_id(invoice_id)
    return false if transactions.empty?
    transactions.any? do |transaction|
      transaction.result == :success
    end
  end

  def paid_invoice_filter
    customer_invoice_ids = invoices_per_customer
    paid_invoices_by_customer = {}
    customer_invoice_ids.each do |customer_id, invoices|
      paid_invoices = invoices.find_all do |invoice|
        invoice if invoice_paid_in_full?(invoice.id)
      end
      paid_invoices_by_customer[customer_id] = paid_invoices
    end

    paid_invoices_by_customer.delete_if do |_customer_id, invoice_results|
      invoice_results.empty?
    end
    paid_invoices_by_customer
  end

  def invoice_totals_by_customer
    paid_invoices = paid_invoice_filter
    invoice_totals_by_customer = {}
    paid_invoices.each do |customer_id, invoices|
      invoice_totals = invoices.map do |invoice|
        invoice_total(invoice.id)
      end
      invoice_totals_by_customer[customer_id] = invoice_totals.reduce(:+)
    end
    invoice_totals_by_customer
  end

  def sort_totals
    results = invoice_totals_by_customer
    sorted_totals = results.sort_by do |_customer_id, total|
      total
    end.reverse
    sorted_totals
  end

  def invoice_status(status_to_check)
    total = number_of(:invoices).to_f
    total_at_status = number_of_invoices_by_status(status_to_check).length.to_f
    ((total_at_status / total) * 100).round(2)
  end

  def total_invoice_items(invoice_id)
    invoice_items = @invoice_item_repo.find_all_by_invoice_id(invoice_id)
    invoice_items.map(&:quantity).reduce(:+)
  end
end
